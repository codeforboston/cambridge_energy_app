class Unit < ActiveRecord::Base
  belongs_to :user_building
  has_many :users, dependent: :destroy # Again, ruthless. Or :nullify? But that would just break everything.
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
