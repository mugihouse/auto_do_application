class LineBotMessagesController < ApplicationController
  # CSRF対策を無効化
  protect_from_forgery except: [:callback]

  def callback
    LineBotService.new(request).reply
    head :ok
  end
end
