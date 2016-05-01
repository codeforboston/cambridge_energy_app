require 'rails_helper'

describe UnitsController do
  before(:each) do
    @unit = create(:unit)
    @user = create(:user, unit: @unit)
    sign_in @user
  end

  describe 'GET #show' do
    it 'is successful' do
      get(:show, id: @unit.id)

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
      get(:edit, id: @unit.id)

      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    let(:user_building) { create(:user_building) }

    it 'is successful' do
      unit = attributes_for(:unit).merge(user_building_id: user_building.id)

      expect{ post(:create, unit: unit) }.to change{ Unit.count }.by(1)
      expect(response).to redirect_to Unit.last
    end

    it 'is not successful due to failing validations' do
      unit = attributes_for(:unit, number_occupants: 21)
        .merge(user_building_id: user_building.id)

      expect{ post(:create, unit: unit) }.to_not change{ Unit.count }
      expect(response).to render_template :new
    end
  end

  describe 'PATCH #update' do
    it 'is successful' do
      patch = lambda do
        patch(
          :update,
          id: @unit.id,
          unit: { number_occupants: 5 }
        )
      end

      expect(&patch).to_not change{ Unit.count }
      expect(response).to redirect_to @unit
    end

    it 'is not successful due to failing validations' do
      patch = lambda do
        patch(
          :update,
          id: @unit.id,
          unit: { number_occupants: 21 }
        )
      end

      expect(&patch).to_not change{ Unit.count }
      expect(response).to render_template :edit
    end
  end
end
