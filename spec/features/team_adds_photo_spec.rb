require "rails_helper"
require "spec_helper"
include Warden::Test::Helpers

feature "user can add photo to team" do
  scenario "user uploads failing filetype" do
    user = create(:user)
    team = create(:team)
    login_as user, :scope => :user
    visit "/teams/new"
    fill_in "Name", with: "Test Team"
    attach_file "Image url", "#{Rails.root}/spec/controllers/bills_controller_spec.rb"
    click_button "Create Team"
    expect(page).to have_content "Image url file should be one of image/jpeg, image/png, image/jpg"
  end

  scenario "user uploads allowed filetype" do
    user = create(:user)
    team = create(:team)
    login_as user, :scope => :user
    visit "/teams/new"
    fill_in "Name", with: "Test Team"
    attach_file "Image url", "#{Rails.root}/spec/support/tux.jpg"
    click_button "Create Team"
    expect(page).to have_css("img[src*='tux.jpg']")
  end
end
