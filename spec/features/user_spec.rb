require "rails_helper"

describe 'Users' do
  let(:user) { create(:user, password: '12345678') }

  feature "user can invite existing user to join team" do
    scenario "user successfully invites existing user" do
      login_as user, :scope => :user
      visit "/users/invitation/new"
      fill_in "Email", with: user.email

      #click button: send an invitation
      find('input[name="commit"]').click
      expect(page).to have_content "#{user.email} has been invited to join your team"
    end
  end

  feature 'User can sign in' do
    scenario 'from the navbar' do
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

  feature "user can add a new bill" do
    scenario "user successfully adds new bill" do
      visit "/"
      fill_in "datepicker", with: "2016-03-16"
      fill_in "usage", with: "400"
      fill_in "occupants", with: "5"
      click_button "Create Bill"

      expect(page).to have_content "Sign up to learn how to save money on your energy bill:"
      expect(page).to have_css "svg#graph"
      expect(page).to_not have_content "Date Bill is Due"
    end

    scenario "user does not enter any bill information" do
      visit "/"
      click_button "Create Bill"

      expect(page).to have_content "Number occupants can't be blank"
      expect(page).to have_content "Number occupants is not a number"
      expect(page).to have_content "Bill received must be a valid date"
      expect(page).to have_content "Bill received can't be blank"
      expect(page).to have_content "Usage can't be blank"
      expect(page).to have_content "Usage is not a number"
      expect(page).to_not have_css "svg#graph"
    end

    scenario "user enters invalid bill information - greater than case" do
      visit "/"
      fill_in "datepicker", with: "5"
      fill_in "usage", with: "10000"
      fill_in "occupants", with: "21"
      click_button "Create Bill"

      expect(page).to have_content "Number occupants must be less than or equal to 20"
      expect(page).to have_content "Bill received must be a valid date"
      expect(page).to have_content "Bill received can't be blank"
      expect(page).to have_content "Usage must be less than or equal to 9999"
      expect(page).to_not have_css "svg#graph"
    end

    scenario "user enters invalid bill information - less than case" do
      visit "/"
      fill_in "datepicker", with: "5"
      fill_in "usage", with: "-1"
      fill_in "occupants", with: "-10"
      click_button "Create Bill"

      expect(page).to have_content "Number occupants must be greater than or equal to 0"
      expect(page).to have_content "Bill received must be a valid date"
      expect(page).to have_content "Bill received can't be blank"
      expect(page).to have_content "Usage must be greater than or equal to 0"
      expect(page).to_not have_css "svg#graph"
    end

    scenario "from the teams leaderboard" do
      login_as(user, scope: :user)

      visit authenticated_root_path
      click_on I18n.t('bills.add')

      fill_in "datepicker", with: "2016-03-16"
      fill_in "usage", with: "400"
      click_button I18n.t('bills.create')

      expect(page).to have_content I18n.t('graph.title')
      expect(page).to have_css "svg#graph"
    end
  end
end
