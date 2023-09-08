class Notification < ApplicationRecord
  belongs_to :task
  belongs_to :user

  scope :today_send_messages, -> { where(delivery_date: DateTime.current.all_day )}
end
