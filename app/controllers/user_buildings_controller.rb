class UserBuildingsController < ApplicationController
  before_action :set_user_building, only: [:authorize_user, :show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]

  # GET /user_buildings
  # GET /user_buildings.json
  def index
    @user_buildings = policy_scope(UserBuilding)
  end

  # GET /user_buildings/1
  # GET /user_buildings/1.json
  def show
  end

  # GET /user_buildings/new
  def new
    authorize UserBuilding
    @user_building = UserBuilding.new
  end

  # GET /user_buildings/1/edit
  def edit
  end

  # POST /user_buildings
  # POST /user_buildings.json
  def create
    authorize UserBuilding
    @user_building = UserBuilding.new(user_building_params)

    respond_to do |format|
      if @user_building.save
        format.html { redirect_to @user_building, notice: 'User building was successfully created.' }
        format.json { render :show, status: :created, location: @user_building }
      else
        format.html { render :new }
        format.json { render json: @user_building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_buildings/1
  # PATCH/PUT /user_buildings/1.json
  def update
    respond_to do |format|
      if @user_building.update(user_building_params)
        format.html { redirect_to @user_building, notice: 'User building was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_building }
      else
        format.html { render :edit }
        format.json { render json: @user_building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_buildings/1
  # DELETE /user_buildings/1.json
  def destroy
    @user_building.destroy
    respond_to do |format|
      format.html { redirect_to user_buildings_url, notice: 'User building was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between
    # actions.
    def set_user_building
      @user_building = UserBuilding.find(params[:id])
    end

    def authorize_user
      authorize @user_building
    end

    # Never trust parameters from the scary internet, only allow
    # the white list through.
    def user_building_params
      params.
        require(:user_building).
        permit(:address, :lat, :lon)
    end
end
