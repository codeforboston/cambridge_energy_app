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
    let(:team_with_score) { create :team_with_members }
    let(:user) { create(:user, team: team_with_members, bills: []) }

    it 'should return a score if at least one team member has sufficient bills' do
      # RE-RUN: if the factory randomly selects bills with similar values test fails"
      expect(team_with_score.score).not_to eq 0
    end

    it 'should return 0 if the team lacks sufficient bills' do
      expect(team.score).to eq 0
    end
  end
end
