class Unit < ActiveRecord::Base
  belongs_to :user_building
  has_many :users
  has_many :bills
  after_initialize :init

  def init
    self.unit_number ||= "1"
  end
  
  
  validates :number_occupants, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 20
  }
end
