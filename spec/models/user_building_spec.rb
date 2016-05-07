require 'rails_helper'

describe UserBuilding do
	it { should have_many :units }
	it 'is invalid without an address' do
		user_building = build(:user_building, address: nil)
		user_building.valid?
		expect(user_building.errors[:address]).to include("can't be blank")
	end
	it 'has as many addresses as user_buildings' do
		expect (UserBuilding.all.count == UserBuilding.all_addresses.count)
	end
end
