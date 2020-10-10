class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :events, foreign_key: "creator_id", dependent: :destroy
end
