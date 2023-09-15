class Profile < ApplicationRecord
  belongs_to :user

  has_many :profile_day_of_weeks, dependent: :destroy
  has_many :day_of_weeks, :through => :profile_day_of_weeks

  validates :dinner_time, presence: true
  validates :bedtime, presence: true
  validates :notification_setting, presence: true
  validates :notification_setting, inclusion: { in: ['turn_on', "turn_off"] }

  enum notification_setting: { turn_on: true, turn_off: false }

  def time_between?(dinner_time: set_dinner_time, now_time: set_current_time, bedtime: set_bedtime)
    if dinner_time <= bedtime
      dinner_time <= now_time && now_time < bedtime
    else
      now_time < bedtime || dinner_time <= now_time
    end
  end

  def set_dinner_time
    self.dinner_time.strftime('%H%M').to_i
  end

  def set_bedtime
    self.bedtime.strftime('%H%M').to_i
  end

  def set_current_time
    DateTime.current.strftime('%H%M').to_i
  end
end
