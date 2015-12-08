class UserBuilding < ActiveRecord::Base
  has_many :units
  has_many :users, through: :units

  validates :address, presence: true
  validates :lat, numericality: true
  validates :lon, numericality: true
end
