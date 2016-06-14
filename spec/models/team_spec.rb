require 'rails_helper'

describe Team do

  before(:each) do
    @team = create(:team)
  end

  context "Validations" do
    it { should validate_presence_of :name }
  end

  context "Associations" do
    it { should have_many :users }
  end

  it 'has a valid factory' do
    expect(@team).to be_valid
  end

  describe '.score' do
    let(:team) { create(:team_with_members) }
    it 'should return a score for the team if it has sufficient bills' do
      expect(team.score).not_to eq 0
    end

    it 'should return 0 if the team lacks sufficient bills' do
      expect(@team.score).to eq 0
    end
  end
end
