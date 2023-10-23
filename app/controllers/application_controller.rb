class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :login_required
  helper_method :logged_in?

  add_flash_types :success, :info, :warning, :danger

  private

  def set_liff_id
    gon.liff_id = ENV.fetch('LIFF_ID', nil)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
      flash[:danger] = t('defaults.messages.require_login')
      redirect_back fallback_location: root_path
    end

  end

  def logged_in?
    !current_user.nil?
  end
end
