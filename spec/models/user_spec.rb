require 'rails_helper'

describe User do

  before(:each) do
    @user = create(:user)
  end

  it { should belong_to :team }
  it { should belong_to :unit }
  it { should have_many :bills }
  it { should validate_length_of(:phone).is_equal_to(10), if: :phone }
  it { should validate_numericality_of(:phone).only_integer }

  it 'has a valid factory' do
    expect(@user).to be_valid
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
        @user.update(first_name: nil, email: 'bob@everyman.com')
        expect(@user.first_name_or_email).to eq 'bob'
      end
    end

    context 'first name is empty' do
      it 'should return .email_without_domain' do
        @user.update(first_name: '', email: 'bob@everyman.com')
        expect(@user.first_name_or_email).to eq 'bob'
      end
    end

    context 'first name is neither nil or empty' do
      it 'should return first_name' do
        expect(@user.first_name).to eq 'Bob'
      end
    end
  end

  describe '.is_member?(team)' do
    let(:team1) { create(:team) }
    let(:team2) { create(:team) }
    let(:user) { create(:user, team: team1) }

    it 'should return true if user belong_to team' do
      expect(user.is_member?(team1)).to eq true
    end

    it 'should return false if user dont belong_to team' do
      expect(user.is_member?(team2)).to eq false
    end
  end

  describe '.score' do
    let(:user) { create(:user_with_bills) }

    it 'should return a score that is not zero if it has two or more bills' do
      expect(user.score).not_to eq 0
    end

    it 'should return 0 if it has less than two bills' do
      expect(@user.score).to eq 0
    end
  end
end
