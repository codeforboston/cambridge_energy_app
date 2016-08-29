require 'rails_helper'

RSpec.describe Api::V1::AddressesController do
  describe 'GET #index' do
    it 'gets all the building addresses' do
      buildings = create_list(:user_building, 2)

      get :index

      expect(json_response).not_to be_empty
      expect(json_response.map{|h| h['value']}).to eq buildings.map(&:id)
    end
  end
end
