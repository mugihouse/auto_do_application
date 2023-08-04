class DayOfWeek < ApplicationRecord
  has_many :profile_day_of_weeks
  has_many :profiles, :through => :profile_day_of_weeks
end
