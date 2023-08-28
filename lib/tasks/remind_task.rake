task remind_today_task: :environment do
  users = User.all
  time = Time.now.strftime("%H:%M")
  today = Time.now.wday + 1

  client = Line::Bot::Client.new do |config|
    config.channel_secret = ENV['BOT_CHANNEL_SECRET']
    config.channel_token = ENV['BOT_CHANNEL_TOKEN']
  end

  # 平日なら配信
  users.each do |user|
    if (user.profile.dinner_time + 1.hour).strftime("%H:%M") == time
      user.profile.day_of_weeks.ids.each do |day_of_week|
        if day_of_week == today
          line_id = user.line_id
				  task = (user.tasks.middle + user.tasks.long).sample
          message = { type: 'text',
                      text: "今日のタスク\nタイトル: #{task.title}\n内容:#{task.body}"}
          client.push_message(line_id, message)
        else
          line_id = user.line_id
				  task = user.tasks.short.sample
          message = { type: 'text',
                      text: "今日のタスク\nタイトル: #{task.title}\n内容:#{task.body}"}
          client.push_message(line_id, message)
        end
      end
    end
  end
end
