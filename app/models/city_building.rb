class CityBuilding < ActiveRecord::Base
  has_many :units
  belongs_to :landlord
end
