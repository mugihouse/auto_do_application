namespace :notification_task do
  task remind_today_task: :environment do
    users = User.all
    time = DateTime.now.strftime("%H:%M")
    today = DateTime.now.wday + 1

    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('BOT_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('BOT_CHANNEL_TOKEN', nil)
    end

    users.each do |user|
      break if user.profile.nil? || user.profile.turn_off?

      if (user.profile.dinner_time + 1.hour).strftime("%H:%M") == time
        if user.profile.day_of_weeks.ids.include?(today)
          # 休日の場合
          @task = (user.tasks.middle + user.tasks.long).sample
        else
          # 平日の場合
          @task = user.tasks.short.sample
        end

        break if @task.nil?

        line_id = user.line_id
        notification = @task.notifications.new(delivery_date: DateTime.current, user_id: user.id)
        notification.save

        message = { "type": "template",
                    "altText": "今日のタスク",
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
        client.push_message(line_id, message)
    end
    end
  end
end
