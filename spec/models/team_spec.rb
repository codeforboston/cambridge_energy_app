require 'rails_helper'

describe Team do

let(:team) { create :team }

  context "Validations" do
    it { should validate_presence_of :name }
  end

  context "Associations" do
    it { should have_many :users }
  end

  it 'has a valid factory' do
    expect(team).to be_valid
  end

  describe '.score' do
    let(:user) { create(:user, bills: []) }
    let(:team_with_score) { create :team_with_members }

    it 'should return a score if at least one team member has sufficient bills' do
      # RE-RUN: if the factory randomly selects bills with similar values test fails"
      team_with_score.users.push(user)
      expect(team_with_score.score).not_to eq 0
    end

    it 'should return 0 if the team lacks sufficient bills' do
      expect(team.score).to eq 0
    end
  end
end
