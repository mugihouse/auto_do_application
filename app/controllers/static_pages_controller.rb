class StaticPagesController < ApplicationController
  def top
    unless current_user
      render :before_login
    else
      @total = []
      @notifications = Notification.where(user_id: current_user.id)
      gon.total = this_week_task
    end
  end

  def before_login; end

  def terms; end

  def privacy; end

  private

  def this_week_task
    6.downto(1) { |num|
      @total.push(@notifications.done_day_ago(num).map(&:put_time).sum)
    }
    @total.push(@notifications.done_today.map(&:put_time).sum)
  end
end
