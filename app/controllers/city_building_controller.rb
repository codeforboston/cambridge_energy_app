class CityBuildingController < ApplicationController
    
    @landlord = Landlord.find(params[:landlord_id])
    
    def index
        @city_building = @landlord.city_buildings.all
    end
    
    def show
        @city_building = @landlord.city_buildings.find(params[:id])
    end
    
    def new
        @city_building = @landlord.city_buildings.new
    end
    
    def edit
        @city_building = @landlord.city_buildings.find(params[:id])
    end
    
    def create
        @city_building = @landlord.city_buildings.create(city_building_params)
        @redirect_to user_building_path(@landlord)
    end 

    def update
        
        @city_building = @landlord.city_buildings.find(params[:id])
        
        if city_building.update(city_building_params)
            redirect_to @city_building
        else
            render 'edit'
        end
    end

    def destroy
        @city_building = @landlord.city_buildings.find(params[:id])
        @city_building.destroy
        redirect_to landlord_path(@landlord)
    
private
    def city_building_params
        params.require(:city_building).permit() #NEEDS ASSESSORS DATA, ENERGY REPORTING INFO
    end
