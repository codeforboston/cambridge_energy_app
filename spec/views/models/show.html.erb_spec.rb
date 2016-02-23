require 'rails_helper'

RSpec.describe "models/show", type: :view do
  before(:each) do
    @model = assign(:model, Model.create!(
      :Invitation => "Invitation",
      :user_id => 1,
      :team_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Invitation/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
