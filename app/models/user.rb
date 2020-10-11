class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :events, foreign_key: "creator_id", dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: "Event"
end
