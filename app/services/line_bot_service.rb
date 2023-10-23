class LineBotService
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def reply
    body = @request.body.read

    signature = @request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      message = case event.type
                when Line::Bot::Event::MessageType::Text
                  @user = User.find_by(line_id: event['source']['userId'])
                  @profile = @user.profile
                  # ユーザーからの返答メッセージで場合分け
                  case event.message['text']

                  when 'タスクを完了しました'
                    today_notifications = Notification.all.today_send_messages(@user.id)
                    today_notifications.map(&:done_task!)

                    if @profile.time_between?
                      {
                        type: 'template',
                        altText: '次のタスクに移りますか？',
                        template: {
                          type: 'buttons',
                          text: '次のタスクに移りますか？',
                          actions: [
                            message_button_template('はい', 'はい'),
                            message_button_template('いいえ', 'いいえ')
                          ]
                        }
                      }
                    else
                      text_message("配信時間を超えました\n次の配信までしばらくお待ちください😌")
                    end
                  when 'はい'
                    today = DateTime.now.wday + 1

                    # 配信時間内か判定
                    if @profile.time_between?
                      # ユーザーに配信したタスクの有無をチェック
                      if Notification.today_send_task(@user.id).present?
                        text_message('先ほど配信したタスクが終わっていません！')
                      else
                        # 平日タスクと休日タスクで場合分け
                        today_notification_tasks = Notification.all.today_send_messages(@user.id).map(&:task)
                        @task = if @profile.day_of_weeks.ids.include?(today)
                                  # 休日の場合
                                  (@user.tasks.middle + @user.tasks.long - today_notification_tasks).sample
                                else
                                  # 平日の場合
                                  (@user.tasks.short - today_notification_tasks).sample
                                end

                        if @task.nil?
                          text_message("タスクを全て完了しました！\n今日の配信は終わりです😊")
                        else
                          notification = @task.notifications.new(delivery_date: DateTime.current, user_id: @user.id)
                          notification.save

                          {
                            type: 'template',
                            altText: '次のタスク',
                            template: {
                              type: 'buttons',
                              text: "タイトル: #{@task.title}\n内容: #{@task.body}",
                              actions: [
                                message_button_template('完了', 'タスクを完了しました')
                              ]
                            }
                          }
                        end
                      end
                    else
                      text_message("配信時間を超えました\n次の配信までしばらくお待ちください😌")
                    end
                  when 'いいえ'
                    text_message("お疲れ様でした！\nゆっくり休んでくださいね☺️")
                  end
                end
      client.reply_message(event['replyToken'], message)
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('BOT_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('BOT_CHANNEL_TOKEN', nil)
    end
  end

  def text_message(message)
    {
      type: 'text',
      text: message
    }
  end

  def message_button_template(label_name, text_name)
    {
      type: 'message',
      label: label_name,
      text: text_name
    }
  end
end
