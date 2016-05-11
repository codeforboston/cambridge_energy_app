class UnitsController < ApplicationController
  before_action :set_unit, only: [:authorize_user, :show, :edit, :update, :destroy, :leave]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
    @user_building = UserBuilding.new
  end

  # GET /units/1/edit
  def edit
    @user_building = UserBuilding.find(@unit.user_building_id)
  end

  # POST /units
  # POST /units.json
  def create
    if creating_new_unit? #unit doesn't exist
      @unit = Unit.new(unit_params) 
      respond_to do |format|
        if @unit.valid?
          current_user.unit = @unit
          if creating_new_user_building? #building doesn't exist
            @user_building = UserBuilding.new(user_building_params)
            if @user_building.valid?
              @unit.user_building = @user_building
              @unit.save
              current_user.save
              @user_building.save
              format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
              format.json { render :show, status: :created, location: @unit }
            else
              all_errors = @unit.errors.full_messages + @user_building.errors.full_messages
              format.html { render :new, notice: all_errors }
              format.json { render json: all_errors, status: :unprocessable_entity }
            end
          else #building exists
            @user_building = UserBuilding.find_by(id: params[:unit][:user_building_id])
            if @user_building && @unit.save
              current_user.save
              format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
              format.json { render :show, status: :created, location: @unit }
            else
              format.html { render :new, notice: @unit.errors.full_messages.join(', ') }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        else
          format.html { render :new, notice: @unit.errors.full_messages.join(', ') }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else #unit exists
      if :unit_number.nil?
        @unit = Unit.find_by(user_building_id: params[:unit][:user_building_id], unit_number: "1")
      else
        @unit = Unit.find_by(unit_number: params[:unit][:unit_number],user_building_id: params[:unit][:user_building_id] )
      end
      current_user.unit_id = @unit.id
      respond_to do |format|
        if current_user.save
          format.html { redirect_to @unit, notice: 'Welcome to the unit!' }
          format.json { render :show, status: :ok, location: @unit }
        else
          format.html { redirect_to users_me_path(current_user), notice: "Can't move in." }
          format.json { render json: @unit.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  def leave
    current_user.unit_id = nil
    respond_to do |format|
      if current_user.save
        format.html { redirect_to users_me_path(current_user), notice: "You've moved out." }
        format.json { head :no_content }
      else
        format.html { render :show, notice: "Don't forget: you're here forever." }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    def authorize_user
      unless @unit.id == current_user.unit_id
        flash[:error] = "You do not have permission."
        redirect_to users_me_path(current_user), notice: "Access denied."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:user_building_id, :unit_number, :sqfootage, :number_bedrooms, :number_bathrooms, :number_rooms, :number_occupants)
    end

    def user_building_params
      params.require(:user_building).permit(:address, :lat, :lon)
    end

    def creating_new_unit?
      (:unit_number.present? && Unit.find_by(unit_number: params[:unit][:unit_number].to_s, user_building_id: params[:unit][:user_building_id]).nil?) || (Unit.find_by(user_building_id: params[:unit][:user_building_id]).nil?)
    end

    # If the unit_number exists and the unit :unit_number doesn't, create unit unit_number
    # If the unit_number doesn't exist and the unit 1 doesn't, create unit 1
    # If the unit_number exists and the unit exists, don't create
    # If the unit_number doesn't exist and the unit 1 does, don't create

    
    def creating_new_user_building?
      params[:unit][:user_building_id].empty?
    end
end
