class User_Building_ProfileController < ApplicationController
    
    def new
        @user_building_profile = User_Building_Profile.new
    end
    
    def create
        @user_building_profile = User_Building_Profile.new(profile_params)
    
        if @user_building_profile.save
            redirect_to @user_building_profile
        else 
            render 'new'
        end
    end    
    
    def show
        @user_building_profile = User_Building_Profile.find(params[:id])
    end

private
    def user_profile_params
        params.require(:user_building_profile).permit(:address, :lat, :lon)
    end
