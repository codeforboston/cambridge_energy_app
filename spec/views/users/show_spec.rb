require 'rails_helper'

describe 'users/show.html.erb' do
  let(:building) { build_stubbed :user_building, address: '123 Test St.' }
  let(:unit) { build_stubbed :unit, unit_number: 47, user_building: building }
  let(:user) { build_stubbed :user, unit: unit }

  before do
    assign(:user, user)
    render
  end

  it 'displays the address of the user\'s home' do
    expect(rendered).
      to have_link("#{building.address}, Unit ##{unit.unit_number}", unit_path(unit))
  end
end
