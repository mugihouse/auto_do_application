class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :line_id, presence: true, uniqueness: true
end
