class Notification < ApplicationRecord
  belongs_to :task

  enum status: { send: 0, done: 1 }
end
