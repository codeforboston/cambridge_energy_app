class City_Building_ProfileController < ApplicationController
    
    def new
        @city_building_profile = City_Building_Profile.new
    end
    
    def create
        @city_building_profile = City_Building_Profile.new(profile_params)
    
        if @city_building_profile.save
            redirect_to @city_building_profile
        else 
            render 'new'
        end
    end    
    
    def show
        @city_building_profile = City_Building_Profile.find(params[:id])
    end

private
    def user_profile_params
        params.require(:city_building_profile).permit(:landlord_id) #NEEDS ASSESSORS DATA, ENERGY REPORTING INFO
    end
