class Api::V1::AddressesController < ApplicationController
  before_action :skip_policy_scope

  def index
    @addresses = UserBuilding.all_addresses
    render json: @addresses
  end
end
