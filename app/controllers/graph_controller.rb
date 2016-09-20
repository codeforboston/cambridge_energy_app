class GraphController < ApplicationController
  before_action :skip_policy_scope

  def index
    @user = current_user
  end
end
