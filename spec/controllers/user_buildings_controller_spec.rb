require 'rails_helper'

describe UserBuildingsController do 
  
  def valid_building_params
    {
      address: '2 Harvard St., Cambridge, MA 02138',
      lat: 42.3,
      lon: -71.2
    }
  end

  before(:each) do
    @user_building = create(:user_building)
    @unit = create(:unit, user_building: @user_building)
    @user = create(:user, unit: @unit)
    sign_in @user
  end

  describe 'GET #show' do
    it 'is successful' do
      get(:show, id: @user_building.id)

      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'is successful' do
      get(:new)

      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'is successful' do
      get(:edit, id: @user_building.id)

      expect(response).to render_template :edit
    end
  end

  # describe 'POST #create' do 
  #   context 'creating a new user building' do

  #   end
  # end
end