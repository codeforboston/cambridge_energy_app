require 'rails_helper'

describe User do
	
	# does this slow performance?
	before(:each) do
    @user = create(:user)
  end

  it { should belong_to :team }
  it { should belong_to :unit }
  it { should have_many :bills }
  it { should have_many :invitations }
  it { should have_many :senders }

  it 'has a valid factory' do
  	expect(@user).to be_valid
  end
  
  describe '.phone' do
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
	
	describe '.area_code' do
		it 'should return area code' do
  		expect(@user.area_code).to eq '123'
 		end
 	end

 	describe '.exchange' do
 		it 'should return exchange' do
 			expect(@user.exchange).to eq '456'
 		end
 	end

 	describe '.line' do
 		it 'should return line' do
 			expect(@user.line).to eq '7890'
 		end
 	end

 	describe '.phone_string' do
 		it 'should return phone number with dashes inserted' do
 			expect(@user.phone_string).to eq '123-456-7890'
 		end
 	end

 	describe '.first_name_or_email' do
 		context 'first name is nil' do
 			it 'should return .email_without_domain' do
 				@user.update(first_name: nil)
 				# .send okay to do?
 				expect(@user.first_name_or_email).to eq @user.send(:email_without_domain)
 			end
 		end
 		context 'first name is empty' do
 			it 'should return .email_without_domain' do
 				@user.update(first_name: '')
 				# .send okay to do?
 				expect(@user.first_name_or_email).to eq @user.send(:email_without_domain)
 			end
 		end
 		context 'first name is neither nil or empty' do
 			it 'should return first_name' do
 				expect(@user.first_name).to eq 'Bob'
 			end
 		end
 	end

 	describe '.email_without_domain' do
 		it 'should return characters before @ sign in email' do
 			@user.update(email: 'bruce@wayne.com')
 			# .send okay to do?
 			expect(@user.send(:email_without_domain)).to eq 'bruce'
 		end
 	end

 	# write test for actual score computation
 	# Write test for OmniAuth
end
