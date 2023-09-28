class Task < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :nullify

  validates :title, presence: true
  validates :time_required, presence: true

  enum time_required: { short: 1, middle: 3, long: 5 }
  enum status: { doing: 0, finish: 1 }
end
