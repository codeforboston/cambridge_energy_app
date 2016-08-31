class HomesController < ApplicationController
  before_action :skip_authorization, only: [:index]
  before_action :skip_policy_scope, only: [:index]

  def index
  end

end
