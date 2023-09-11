class LineBotMessagesController < ApplicationController
  # CSRF対策を無効化
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      message = case event
                when Line::Bot::Event::Message
                  case event.type
                  when Line::Bot::Event::MessageType::Text
                    case event.message['text']
                    when "タスクを完了しました"
                      user = User.find_by(line_id: event['source']['userId'])
                      today_notifications = Notification.all.today_send_messages(user.id)
                      today_notifications.map(&:done_task!)

                      { "type": "template",
                        "altText": "次のタスクに移りますか？",
                        "template": {
                          "type": "buttons",
                          "text": "次のタスクに移りますか？",
                          "actions": [
                            {
                              "type": "message",
                              "label": "はい",
                              "text": "はい"
                            },
                            {
                              "type": "message",
                              "label": "いいえ",
                              "text": "いいえ"
                            }
                          ]
                        }
                      }
                    when "はい"
                      user = User.find_by(line_id: event['source']['userId'])
                      today = DateTime.now.wday + 1

                      if Notification.all.today_send_task(user.id).present?
                        { "type": "text",
                        "text": "先ほど配信したタスクが終わっていません！",
                        }
                      else
                        # 平日タスクと休日タスクで場合分け
                        today_notification_tasks = Notification.all.today_send_messages(user.id).map(&:task)
                        if user.profile.day_of_weeks.ids.include?(today)
                          # 休日の場合
                          @task = (user.tasks.middle + user.tasks.long - today_notification_tasks).sample
                        else
                          # 平日の場合
                          @task = (user.tasks.short - today_notification_tasks).sample
                        end

                        if @task.nil?
                          { "type": "text",
                            "text": "タスクを全て完了しました！\n今日の配信は終わりです"
                          }
                        else
                          notification = @task.notifications.new(delivery_date: DateTime.current, user_id: user.id)
                          notification.save

                          { "type": "template",
                            "altText": "次のタスク",
                            "template": {
                              "type": "buttons",
                              "text": "タイトル: #{@task.title}\n内容: #{@task.body}",
                              "actions": [
                                {
                                  "type": "message",
                                  "label": "完了",
                                  "text": "タスクを完了しました"
                                }
                              ]
                            }
                          }
                        end
                      end
                    when "いいえ"
                      { "type": "text",
                        "text": "お疲れ様でした！\nゆっくり休んでくださいね$",
                        "emojis": [
                          {
                            "index": 21,
                            "productId": "5ac1bfd5040ab15980c9b435",
                            "emojiId": "009"
                          }
                        ]
                      }
                    end
                  end
                end
      client.reply_message(event['replyToken'], message)
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['BOT_CHANNEL_SECRET']
      config.channel_token = ENV['BOT_CHANNEL_TOKEN']
    end
  end

end
