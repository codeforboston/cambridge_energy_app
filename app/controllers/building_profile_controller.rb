class Building_ProfileController < ApplicationController
    
    def new
        @building_profile = Building_Profile.new
    end
    
    def create
        @building_profile = Building_Profile.new(profile_params)
    
        if @building_profile.save
            redirect_to @user_profile
        else 
            render 'new'
        end
    end    
    
    def show
        @building_profile = Building_Profile.find(params[:id])
    end

private
    def user_profile_params
        params.require(:building_profile).permit(STUFF)
    end
