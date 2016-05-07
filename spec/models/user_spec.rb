require 'rails_helper'

describe User do

  it { should belong_to :team }
  it { should belong_to :unit }
  it { should have_many :bills }
  it { should have_many :invitations }
  it { should have_many :senders }

  it 'has a valid factory' do
  	expect(build(:user)).to be_valid
  end
  
  context 'phone' do
  	it 'must have 10 characters' do
  		user = build(:user, phone: '617')
  		user.valid?
  		expect(user.errors[:phone]).to include("is the wrong length (should be 10 characters)")
  	end
  	it 'should only have numeric characters' do
  		user = build(:user, phone: '617-555-5555')
  		user.valid?
  		expect(user.errors[:phone]).to include("is not a number")
  	end
  end
end
