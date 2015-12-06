class UserBuildingController < ApplicationController
    
    def index
        @user_building = UserBuilding.all
    end
    
    def show
        @user_building = UserBuilding.find(params[:id])
    end
    
    def new
        @user_building = UserBuilding.new
    end
    
    def edit
        @user_building = UserBuilding.find(params[:id])
    end
    
    def create
        @user_building = UserBuilding.new(user_building_params)
    
        if @user_building.save
            redirect_to @user_building
        else 
            render 'new'
        end
    end    
    
    def update
        @user_building = UserBuilding.find(params[:id])
        
        if user_building.update(user_building_params)
            redirect_to @user_buidling
        else
            render 'edit'
        end
    end
    
    def destroy
        @user_building = UserBuidling.find(params[:id])
        @user_buidling.destroy
        redirect_to user_building_path

private
    def user_building_params
        params.require(:user_building).permit(:address, :lat, :lon)
    end
