class UserBuilding < ActiveRecord::Base
  has_many :units

  validates :address, presence: true, allow_blank: false

  def self.all_addresses
    all.map { |ub| { label: ub.address, value: ub.id } }
  end

  def self.find_or_generate(user_building_id, address_input)
    if user_building_id.empty?
      # create a new user_building with the address given by user
      # if valid, save it
      # if not, it will be returned to user w/errors
      user_building = UserBuilding.new(address: address_input)
      if user_building.valid?
        user_building.save
      end
    else
      # find the user_building based on the id
      user_building = UserBuilding.find(user_building_id)
    end
    return user_building
  end
end
