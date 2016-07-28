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

  describe 'GET #index' do
    it 'is successful' do
      get(:index)

      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    it 'is successful' do
      get(:edit, id: @user_building.id)

      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'creating a new user building' do
      it 'creates a building with valid params' do
        post = lambda do
          post(
            :create,
            user_building: valid_building_params
            )
        end

        expecting = expect(&post)
        expecting.to change{ UserBuilding.count }.by(1)
        expect(response).to redirect_to UserBuilding.last
      end

      it 'refuses to save a building without address' do
        params_without_address = valid_building_params.merge(address: '')
        post = -> { post(:create, user_building: params_without_address) }

        expectation = expect(&post)
        expectation.to_not change{ UserBuilding.count }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'updating a user building' do

      valid_addresses = ['14 Beacon St., Greenwich, England', 'amishcountry', '4']
      invalid_addresses = ['', ' ']

      valid_addresses.each do |address|
        it "updates a building with valid params like '#{address}'" do
          patch = lambda do
            patch(
              :update,
              id: @user_building.id,
              user_building: {
                address: address
              }
              )
          end

          expecting = expect(&patch)
          expecting.to_not change{ UserBuilding.count }
          expect(response).to redirect_to @user_building
          expect(valid_addresses).to include(@user_building.reload.address)
        end
      end

      invalid_addresses.each do |address|
        it "refuses to update a building with invalid address like '#{address}'" do
          patch = lambda do
            patch(
              :update,
              id: @user_building.id,
              user_building: {
                address: address
              }
              )
          end

          expecting = expect(&patch)
          expecting.to_not change{ UserBuilding.count }
          expect(@user_building.address_changed?).to be(false)
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'demolishes building' do
      delete = lambda do
        delete(
          :destroy,
          id: @user_building.id
          )

        expecting = expect(&delete)
        expecting.to change{ UserBuilding.count }.by(-1)
        expect(response).to redirect_to user_buildings_path
      end
    end
  end

end
