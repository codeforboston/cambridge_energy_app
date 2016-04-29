class UserBuilding < ActiveRecord::Base
  has_many :units

  validates :address, presence: true

  def self.all_addresses
    all.map { |ub| { label: ub.address, value: ub.id } }
  end
end
