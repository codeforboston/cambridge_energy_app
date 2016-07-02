require 'rails_helper'

describe UserBuilding do
  it { should have_many :units }
  it { should validate_presence_of(:address) }

  before(:each) do 
  	UserBuilding.all.each{|b| b.destroy}
  	@user_building = create(:user_building)
  end

  describe '.all_addresses' do
    it 'returns as many addresses as there are user_buildings' do
      expect(UserBuilding.all.count).to eq UserBuilding.all_addresses.count
    end
  end

  describe '.find_or_generate' do

  	it 'should return a building by matching id' do 
  		b = UserBuilding.find_or_generate(@user_building.id, nil)
  		expect(b).to eq(@user_building)
  	end

  	it 'should match exact address' do
  		b = UserBuilding.find_or_generate(nil, @user_building.address)
  		expect(b).to eq(@user_building)
  	end

  	[
	  	'123 main st, cambridge, ma',
	  	'123 main st cambridge ma', #fail
	  	'123 Main st., Cambridge MA',
	  	'123 main st., Cambridge, Massachussets 02138', #fail
	  	'123 main st., Cambrdige, Masachussetts', #fail
	  	'123 main st cambridge, massachussetts' #fail
	  ].each do |address|

  		it "should return match by address '#{address}'" do
  			match = UserBuilding.find_or_generate(nil, address) 	
  			expect(match).to eq(@user_building)
  		end
  		
  		# => Failed examples:

  		# rspec './spec/models/user_building_spec.rb[1:4:4]' # UserBuilding.find_or_generate should return match by address '123 main st cambridge ma'
  		# rspec './spec/models/user_building_spec.rb[1:4:6]' # UserBuilding.find_or_generate should return match by address '123 main st., Cambridge, Massachussets 02138'
  		# rspec './spec/models/user_building_spec.rb[1:4:7]' # UserBuilding.find_or_generate should return match by address '123 main st., Cambrdige, Masachussetts'
  		# rspec './spec/models/user_building_spec.rb[1:4:8]' # UserBuilding.find_or_generate should return match by address '123 main st cambridge, massachussetts'
  	end
  	
  end
end
