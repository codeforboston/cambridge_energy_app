class Unit < ActiveRecord::Base
  belongs_to :user_building
  has_many :users
  validates :unit_number
  validates :sqfootage, numericality: true, greater_than: 0
  validates :appliances
end
