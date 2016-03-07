require 'rails_helper'

RSpec.describe "invitations/edit", type: :view do
  before(:each) do
    @invitation = assign(:invitation, Invitation.create!(
      :email => "MyString",
      :inviter => nil,
      :receiver => nil,
      :sender => nil,
      :token => "MyString"
    ))
  end

  it "renders the edit invitation form" do
    render

    assert_select "form[action=?][method=?]", invitation_path(@invitation), "post" do

      assert_select "input#invitation_email[name=?]", "invitation[email]"

      assert_select "input#invitation_inviter_id[name=?]", "invitation[inviter_id]"

      assert_select "input#invitation_receiver_id[name=?]", "invitation[receiver_id]"

      assert_select "input#invitation_sender_id[name=?]", "invitation[sender_id]"

      assert_select "input#invitation_token[name=?]", "invitation[token]"
    end
  end
end
