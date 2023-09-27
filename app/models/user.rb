class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :line_id, presence: true, uniqueness: true

  enum role: { general: 0, admin: 1 }
end
