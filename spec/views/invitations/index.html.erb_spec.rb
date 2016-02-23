require 'rails_helper'

RSpec.describe "invitations/index", type: :view do
  before(:each) do
    assign(:invitations, [
      Invitation.create!(
        :user_id => 1,
        :team_id => 2
      ),
      Invitation.create!(
        :user_id => 1,
        :team_id => 2
      )
    ])
  end

  it "renders a list of invitations" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
