require 'rails_helper'

RSpec.describe "models/index", type: :view do
  before(:each) do
    assign(:models, [
      Model.create!(
        :Invitation => "Invitation",
        :user_id => 1,
        :team_id => 2
      ),
      Model.create!(
        :Invitation => "Invitation",
        :user_id => 1,
        :team_id => 2
      )
    ])
  end

  it "renders a list of models" do
    render
    assert_select "tr>td", :text => "Invitation".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
