class Unit_Profile < ActiveRecord::Base
  validates :building_id
  validates :unit_number
  validates :sqfootage, numericality: true, greater_than: 0
  validates :appliances
end
