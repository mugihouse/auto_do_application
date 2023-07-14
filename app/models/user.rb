class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :line_id, presence: true
end
