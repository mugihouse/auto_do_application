class Notification < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :user

  enum status: { send_task: 0, done_task: 1 }

  scope :today_send_messages, -> (user_id){ where(delivery_date: DateTime.current.all_day, user_id: user_id)}
end
