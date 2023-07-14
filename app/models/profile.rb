class Profile < ApplicationRecord
  belongs_to :user

  validates :dinner_time, presence: true
  validates :bedtime, presence: true
  validates :holiday_of_week, presence: true
end
