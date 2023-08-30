task remind_today_task: :environment do
  users = User.all
  time = Time.now.strftime("%H:%M")
  today = Time.now.wday + 1

  client = Line::Bot::Client.new do |config|
    config.channel_secret = ENV['BOT_CHANNEL_SECRET']
    config.channel_token = ENV['BOT_CHANNEL_TOKEN']
  end

  users.each do |user|
    if (user.profile.dinner_time + 1.hour).strftime("%H:%M") == time
      if user.profile.day_of_weeks.ids.include?(today)
        # 今日が休日の場合
        line_id = user.line_id
        task = (user.tasks.middle + user.tasks.long).sample
        message = { "type": "template",
                    "altText": "今日のタスク",
                    "template": {
                      "type": "buttons",
                      "text": "タイトル: #{task.title}\n内容: #{task.body}",
                      "actions": [
                        {
                          "type": "message",
                          "label": "完了",
                          "text": "タスクを完了しました"
                        }
                      ]
                    }
                  }
        client.push_message(line_id, message)
      else
        # 今日が平日の場合
        line_id = user.line_id
        task = user.tasks.short.sample
        message = { "type": "template",
                    "altText": "今日のタスク",
                    "template": {
                      "type": "buttons",
                      "text": "タイトル: #{task.title}\n内容: #{task.body}",
                      "actions": [
                        {
                          "type": "message",
                          "label": "完了",
                          "text": "タスクを完了しました"
                        }
                      ]
                    }
                  }
        client.push_message(line_id, message)
      end
    end
  end
end
