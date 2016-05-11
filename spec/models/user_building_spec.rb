require 'rails_helper'

describe UserBuilding do
  it { should have_many :units }
  it { should validate_presence_of(:address) }

  describe '.all_addresses' do
    it 'returns as many addresses as there are user_buildings' do
      expect(UserBuilding.all.count).to eq UserBuilding.all_addresses.count
    end
  end
end
