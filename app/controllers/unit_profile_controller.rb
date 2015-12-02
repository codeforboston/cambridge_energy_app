class Unit_ProfileController < ApplicationController
    
    def new
        @unit_profile = Unit_Profile.new
    end
    
    def create
        @unit_profile = Unit_Profile.new(unit_profile_params)
    
        if @unit_profile.save
            redirect_to @unit_profile
        else 
            render 'new'
        end
    end    
    
    def show
        @unit_profile = Unit_Profile.find(params[:id])
    end

private
    def unit_profile_params
        params.require(:unit_profile).permit(:building_id, :unit_number, :sqfootage, :appliances)
    end
