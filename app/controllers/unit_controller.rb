class UnitController < ApplicationController

  @user_building = UserBuilding.find(params[:user_building_id])
  
  def index
    @unit = @user_building.units.all
  end

  def show
    @unit = @user_building.units.find(params[:id])
  end

  def new
    @unit = @user_building.units.new
  end

  def edit
    @unit = @user_building.units.find(params[:id])
  end

  def create
    @unit = @user_building.unit.create(unit_params)
    @redirect_to user_building_path(@user_building)
  end
  
  def update
    @unit = @user_building.units.find(params[:id])

    if @unit.update(unit_params)
      redirect_to @unit
    else
      render 'edit'
    end
  end

  def destroy
    @unit = @user_building.units.find(params[:id])
    @unit.destroy

    redirect_to user_building_path(@user_building)
  end

  private
  def unit_params
    params.require(:unit).permit(:unit_number, :sqfootage)
  end

end
