class UserBuilding < ActiveRecord::Base
  validates :address, presence: true
  validates :lat, numericality: true
  validates :lon, numericality: true
end
