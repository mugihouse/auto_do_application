class Notification < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :user

  validates :status, presence: true
  validates :user_id, presence: true
  validates :task_id, presence: true

  enum status: { send_task: 0, done_task: 1 }

  scope :today_send_messages, -> (user_id){ where(delivery_date: DateTime.current.all_day, user_id: user_id)}
  scope :today_send_task, -> (user_id){ where(delivery_date: DateTime.current.all_day, status: 0, user_id: user_id) }

  scope :done_today, -> { where(created_at: DateTime.now.all_day) } # 今日
  scope :done_1day_ago, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :done_2day_ago, -> { where(created_at: 2.days.ago.all_day) } # 2日前
  scope :done_3day_ago, -> { where(created_at: 3.days.ago.all_day) } # 3日前
  scope :done_4day_ago, -> { where(created_at: 4.days.ago.all_day) } # 4日前
  scope :done_5day_ago, -> { where(created_at: 5.days.ago.all_day) } # 5日前
  scope :done_6day_ago, -> { where(created_at: 6.days.ago.all_day) } # 6日前

  def get_time
    task.time_required_before_type_cast
  end
end
