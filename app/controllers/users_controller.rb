class UsersController < ApplicationController
  require 'net/http'
  require 'uri'

  before_action :set_liff_id, only: %i[new]

  def new
    redirect_to after_login_path if current_user
  end

  def create
    id_token = params[:idToken]
    channel_id = ENV['CHANNEL_ID']
    # IDトークンを検証し、ユーザーの情報を取得
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'), { 'id_token' => id_token, 'client_id' => channel_id })
    # LINEユーザーIDを取得
    line_id = JSON.parse(res.body)['sub']
    user = User.find_or_create_by(line_id: line_id)
    session[:user_id] = user.id
    render json: user
  end

  def destroy
    reset_session
    redirect_to root_path, success: 'ログアウトしました'
  end
end
