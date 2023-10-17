class StaticPagesController < ApplicationController
  def top
    if current_user
      redirect_to :after_login
    else
      render :before_login
    end
  end

  def before_login; end

  def after_login
    @total = []
    @notifications = Notification.all.where(user_id: current_user.id)
    gon.total = this_week_task(current_user.id)
  end

  def terms; end

  def privacy; end

  private
  def this_week_task(user_id)
    @total.push(@notifications.done_6day_ago.map(&:get_time).sum)
    @total.push(@notifications.done_5day_ago.map(&:get_time).sum)
    @total.push(@notifications.done_4day_ago.map(&:get_time).sum)
    @total.push(@notifications.done_3day_ago.map(&:get_time).sum)
    @total.push(@notifications.done_2day_ago.map(&:get_time).sum)
    @total.push(@notifications.done_1day_ago.map(&:get_time).sum)
    @total.push(@notifications.done_today.map(&:get_time).sum)
  end
end
