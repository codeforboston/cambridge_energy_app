require 'rails_helper'

RSpec.describe "models/new", type: :view do
  before(:each) do
    assign(:model, Model.new(
      :Invitation => "MyString",
      :user_id => 1,
      :team_id => 1
    ))
  end

  it "renders new model form" do
    render

    assert_select "form[action=?][method=?]", models_path, "post" do

      assert_select "input#model_Invitation[name=?]", "model[Invitation]"

      assert_select "input#model_user_id[name=?]", "model[user_id]"

      assert_select "input#model_team_id[name=?]", "model[team_id]"
    end
  end
end
