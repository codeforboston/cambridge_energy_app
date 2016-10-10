require "rails_helper"
require "spec_helper"
include Warden::Test::Helpers

feature "user can invite existing user to join team" do
  scenario "user successfully invites existing user" do
    user = create(:user)
    # create another user to send invitation to
    create(:user, email: "existing@example.com")
    login_as user, :scope => :user
    visit "/users/invitation/new"
    fill_in "Email", with: "existing@example.com"
    #click button: send an invitation
    find('input[name="commit"]').click
    expect(page).to have_content "#{user.first_name} has been invited to join your team"
  end
end
