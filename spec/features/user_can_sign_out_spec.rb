require 'rails_helper'

RSpec.feature 'User can sign in' do
  scenario 'from the navbar' do
    user = create(:user, password: '12345678')
    visit root_path

    click_link "Log In"

    fill_in :user_email, with: user.email
    fill_in :user_password, with: '12345678'

    click_button "Log in"
    click_link "Sign Out"

    expect(page).to have_content "Log In"
    expect(current_path).to eq root_path
  end
end
