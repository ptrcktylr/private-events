class Event < ApplicationRecord
  scope :upcoming, -> { where('date >= ?', Time.zone.now) }
  scope :past, -> { where('date < ?', Time.zone.now) }

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :creator, class_name: "User"
end
