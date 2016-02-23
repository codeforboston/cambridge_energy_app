require 'rails_helper'

RSpec.describe "invitations/new", type: :view do
  before(:each) do
    assign(:invitation, Invitation.new(
      :user_id => 1,
      :team_id => 1
    ))
  end

  it "renders new invitation form" do
    render

    assert_select "form[action=?][method=?]", invitations_path, "post" do

      assert_select "input#invitation_user_id[name=?]", "invitation[user_id]"

      assert_select "input#invitation_team_id[name=?]", "invitation[team_id]"
    end
  end
end
