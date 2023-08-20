class LineBotMessagesController < ApplicationController
  skip_before_action :login_required
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
                  { type: 'text', text: event.message['text'] }
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
