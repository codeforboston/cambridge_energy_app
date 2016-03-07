require 'rails_helper'

RSpec.describe "invitations/index", type: :view do
  before(:each) do
    assign(:invitations, [
      Invitation.create!(
        :email => "Email",
        :inviter => nil,
        :receiver => nil,
        :sender => nil,
        :token => "Token"
      ),
      Invitation.create!(
        :email => "Email",
        :inviter => nil,
        :receiver => nil,
        :sender => nil,
        :token => "Token"
      )
    ])
  end

  it "renders a list of invitations" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
  end
end
