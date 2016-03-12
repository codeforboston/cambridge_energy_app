class Unit < ActiveRecord::Base
  belongs_to :user_building
  has_many :users
  has_many :bills

  validates :number_occupants, presence: true, numericality: true, inclusion: {in: [0, 20]}

end
