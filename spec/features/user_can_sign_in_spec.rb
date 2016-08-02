require 'rails_helper'

RSpec.feature 'User can sign in' do
  scenario 'from the navbar' do
    user = create(:user, password: '12345678')
    visit root_path

    within '.top-bar' do
      click_on I18n.t('navigation.sign_in')
    end

    fill_in :user_email, with: user.email
    fill_in :user_password, with: '12345678'

    click_on I18n.t('users.sign_in.submit')

    within '.top-bar' do
      expect(page).to have_content user.first_name_or_email
    end
    expect(current_path).to eq leaderboard_teams_path
  end
end
