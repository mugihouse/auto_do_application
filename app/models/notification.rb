class Notification < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :user

  validates :status, presence: true
  validates :task_id, presence: true

  enum status: { send_task: 0, done_task: 1 }

  scope :today_send_messages, -> (user_id){ where(delivery_date: DateTime.current.all_day, user_id: user_id)}
  scope :today_send_task, -> (user_id){ where(delivery_date: DateTime.current.all_day, status: 0, user_id: user_id) }

  scope :done_today, -> { where(created_at: DateTime.now.all_day) } # 今日
  scope :done_day_ago, -> (num){ where(created_at: num.day.ago.all_day) }

  def put_time
    task.time_required_before_type_cast
  end
end
