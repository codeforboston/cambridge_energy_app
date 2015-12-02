class ProfileController < ApplicationController
    
    def new
        @profile = Profile.new
    end
    
    def create
        @profile = Profile.new(profile_params)
    
        if @profile.save
            redirect_to @profile
        else 
            render 'new'
        end
    end    
    
    def show
        @profile = Profile.find(params[:id])
    end

private
    def profile_params
        params.require(:profile).permit(:streetAddress, :emailAddress, :buildingType, :numberUnitsInBuilding, :householdSize, :energyType, :heatType, :buddy, :team)
    end
