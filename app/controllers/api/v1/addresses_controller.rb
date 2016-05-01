class Api::V1::AddressesController < ApplicationController
  def index
    @addresses = UserBuilding.all_addresses
    render json: @addresses
  end
end
