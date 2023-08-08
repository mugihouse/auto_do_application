class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :time_required, presence: true

  enum time_required: { short: 1, middle: 3, long: 5 }
end
