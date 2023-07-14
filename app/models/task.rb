class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :time_required, presence: true
end
