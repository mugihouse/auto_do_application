class Notification < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :user

  validates :status, presence: true
  validates :user_id, presence: true
  validates :task_id, presence: true

  enum status: { send_task: 0, done_task: 1 }

  scope :today_send_messages, -> (user_id){ where(delivery_date: DateTime.current.all_day, user_id: user_id)}
  scope :today_send_task, -> (user_id){ where(delivery_date: DateTime.current.all_day, status: 0, user_id: user_id) }
end
