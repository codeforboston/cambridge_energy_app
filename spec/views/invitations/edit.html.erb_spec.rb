require 'rails_helper'

RSpec.describe "invitations/edit", type: :view do
  before(:each) do
    @invitation = assign(:invitation, Invitation.create!(
      :user_id => 1,
      :team_id => 1
    ))
  end

  it "renders the edit invitation form" do
    render

    assert_select "form[action=?][method=?]", invitation_path(@invitation), "post" do

      assert_select "input#invitation_user_id[name=?]", "invitation[user_id]"

      assert_select "input#invitation_team_id[name=?]", "invitation[team_id]"
    end
  end
end
