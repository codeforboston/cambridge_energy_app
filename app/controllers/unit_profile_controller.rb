class UnitController < ApplicationController
    
    def new
        @unit = Unit.new
    end
    
    def create
        @unit = Unit.new(unit_params)
    
        if @unit.save
            redirect_to @unit
        else 
            render 'new'
        end
    end    
    
    def show
        @unit = Unit.find(params[:id])
    end

private
    def unit_params
        params.require(:unit).permit(:building_id, :unit_number, :sqfootage, :appliances)
    end
