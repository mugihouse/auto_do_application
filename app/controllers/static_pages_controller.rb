class StaticPagesController < ApplicationController
  skip_before_action :login_required
  
  def top
    if current_user.nil?
      render :before_login
    else
      render :after_login
    end
  end

  def before_login; end

  def after_login
    login_required
  end
end
