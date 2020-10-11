class Event < ApplicationRecord
  scope :upcoming, -> { where('start_time >= ?', Time.zone.now) }
  scope :past, -> { where('start_time < ?', Time.zone.now) }

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :attendees, class_name: "User"
end
