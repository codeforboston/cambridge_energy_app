class CityBuildingController < ApplicationController
    
    @landlord = Landlord.find(params[:landlord_id])
    
    
private
    def city_building_params
        params.require(:city_building).permit(:landlord_id) #NEEDS ASSESSORS DATA, ENERGY REPORTING INFO
    end
