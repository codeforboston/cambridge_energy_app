class CityBuildingController < ApplicationController
    
    def new
        @city_building = CityBuilding.new
    end
    
    def create
        @city_building = CityBuilding.new(city_building_params)
    
        if @city_building.save
            redirect_to @city_building
        else 
            render 'new'
        end
    end    
    
    def show
        @city_building = CityBuilding.find(params[:id])
    end

private
    def city_building_params
        params.require(:city_building).permit(:landlord_id) #NEEDS ASSESSORS DATA, ENERGY REPORTING INFO
    end
