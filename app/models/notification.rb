class Notification < ApplicationRecord
  belongs_to :task

  scope :today_send_messages, -> { where(delivery_date: DateTime.current.all_day )}
end
