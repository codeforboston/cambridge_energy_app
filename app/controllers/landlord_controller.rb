class LandlordController < ApplicationController
    
    def new
        @landlord = Landlord.new
    end
    
    def create
        @landlord = Landlord.new(landlord_params)
    
        if @landlord.save
            redirect_to @landlord
        else 
            render 'new'
        end
    end    
    
    def show
        @landlord = Landlord.find(params[:id])
    end

private
    def landlord_params
        params.require(:landlord).permit(:first_name, :last_name, :email, :phone, :mailing_address)
    end
