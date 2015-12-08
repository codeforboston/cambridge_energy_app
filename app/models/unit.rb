class Unit < ActiveRecord::Base
  belongs_to :user_building
  has_many :users

  validates :unit_number, numericality: true
  validates :sqfootage, numericality: true
  
end
