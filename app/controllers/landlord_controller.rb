class LandlordController < ApplicationController
    
    def index
        @landlord = Landlord.all
    end

    def show
        @landlord = Landlord.find(params[:id])
    end

    def new
        @landlord = Landlord.new
    end

    def edit
        @landlord = Landlord.find(params[:id])
    end

    def create
        @landlord = Landlord.new(landlord_params)
    
        if @landlord.save
            redirect_to @landlord
        else 
            render 'new'
        end
    end

    def update
        @landlord = Landlord.find(params[:id])
    
        if landlord.update(landlord_params)
            redirect_to @landlord
        else
            render 'edit'
        end
    end

    def destroy
        
        @landlord = Landlord.find(params[:id])
        @landlord.destroy
    
        redirect_to landlords_path
    end

private
    def landlord_params
        params.require(:landlord).permit(:first_name, :last_name, :email, :phone, :mailing_address)
    end
