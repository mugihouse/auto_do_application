class Profile < ApplicationRecord
  belongs_to :user

  has_many :profile_day_of_weeks
  has_many :day_of_weeks, :through => :profile_day_of_weeks

  validates :dinner_time, presence: true
  validates :bedtime, presence: true
end
