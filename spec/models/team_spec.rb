require 'rails_helper'

describe Team do

  it { should have_many :users }
  it { should have_many :invitations }
  it { should have_many :receivers }

	before(:each) { @team = create(:team) }

  it 'should destroy associated invitations when destroyed' do
  	@invitation = create(:invitation, sender_id: @team.id)
  	expect { @team.destroy }.to change { Invitation.count }.by(-1)
  end
end
