class Truck < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true
  geocoded_by :location
  after_validation :geocode
end
