class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true
end
