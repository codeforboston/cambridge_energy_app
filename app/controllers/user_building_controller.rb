class UserBuildingController < ApplicationController
    
    def new
        @user_building = UserBuilding.new
    end
    
    def create
        @user_building = UserBuilding.new(user_building_params)
    
        if @user_building.save
            redirect_to @user_building
        else 
            render 'new'
        end
    end    
    
    def show
        @user_building = UserBuilding.find(params[:id])
    end

private
    def user_building_params
        params.require(:user_building).permit(:address, :lat, :lon)
    end
