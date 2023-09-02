class StaticPagesController < ApplicationController
  def top
    if current_user
      render :after_login
    else
      render :before_login
    end
  end

  def before_login; end

  def after_login; end
end
