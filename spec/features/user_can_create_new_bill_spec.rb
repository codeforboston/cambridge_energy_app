require "rails_helper"

feature "user can add a new bill" do
  scenario "user successfully adds new bill" do
    visit "/"
    fill_in "datepicker", with: "2016-03-16"
    fill_in "amount", with: "400"
    fill_in "occupants", with: "5"
    click_button "Create Bill"

    expect(page).to have_content "You can save money on your energy bill"
    expect(page).to have_css "svg#graph"
    expect(page).to_not have_content "Date Bill is Due"
  end

  scenario "user does not enter any bill information" do
    visit "/"
    click_button "Create Bill"

    expect(page).to have_content "Unit number occupants can't be blank"
    expect(page).to have_content "Unit number occupants is not a number"
    expect(page).to have_content "Bill received must be a valid date"
    expect(page).to have_content "Bill received can't be blank"
    expect(page).to have_content "Amount can't be blank"
    expect(page).to have_content "Amount is not a number"
    expect(page).to_not have_css "svg#graph"
  end

  scenario "user enters invalid bill information - greater than case" do
    visit "/"
    fill_in "datepicker", with: "5"
    fill_in "amount", with: "10000"
    fill_in "occupants", with: "21"
    click_button "Create Bill"

    expect(page).to have_content "Unit number occupants must be less than or equal to 20"
    expect(page).to have_content "Bill received must be a valid date"
    expect(page).to have_content "Bill received can't be blank"
    expect(page).to have_content "Amount must be less than or equal to 9999"
    expect(page).to_not have_css "svg#graph"
  end

  scenario "user enters invalid bill information - less than case" do
    visit "/"
    fill_in "datepicker", with: "5"
    fill_in "amount", with: "-1"
    fill_in "occupants", with: "-10"
    click_button "Create Bill"

    expect(page).to have_content "Unit number occupants must be greater than or equal to 0"
    expect(page).to have_content "Bill received must be a valid date"
    expect(page).to have_content "Bill received can't be blank"
    expect(page).to have_content "Amount must be greater than or equal to 0"
    expect(page).to_not have_css "svg#graph"
  end
end
