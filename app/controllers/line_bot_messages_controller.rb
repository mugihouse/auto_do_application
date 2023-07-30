class LineBotMessagesController < ApplicationController
  # CSRF対策を無効化
  protect_from_forgery except: [:callback]

  # 確認用
  OMAJINAI = /アブラカタブラ|チチンプイプイ|ヒラケゴマ/

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      message = case event
                when Line::Bot::Event::Message
                  { type: 'text', text: parse_message_type(event) }
                else
                  { type: 'text', text: '........' }
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

  def parse_message_type(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      reaction_text(event)   # ユーザーが投稿したものがテキストメッセージだった場合に返す値
    else
      'Thanks!!'             # ユーザーが投稿したものがテキストメッセージ以外だった場合に返す値
    end
  end

  def reaction_text(event)
    if event.message['text'].match?(OMAJINAI)
      'It is Omajinai'                          # 定数OMAJINAIに含まれる文字列の内、いずれかに一致した投稿がされた場合に返す値
    elsif event.message['text'].match?('ruby')
      'Is it Programming language? Ore?'        # `ruby`という文字列が投稿された場合に返す値
    else
      event.message['text']                     # 上記２つに合致しない投稿だった場合、投稿と同じ文字列を返す
    end
  end
end
