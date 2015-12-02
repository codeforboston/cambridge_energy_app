class Landlord_ProfileController < ApplicationController
    
    def new
        @landlord_profile = Landlord_Profile.new
    end
    
    def create
        @landlord_profile = Landlord_Profile.new(profile_params)
    
        if @landlord_profile.save
            redirect_to @landlord_profile
        else 
            render 'new'
        end
    end    
    
    def show
        @landlord_profile = Landlord_Profile.find(params[:id])
    end

private
    def landlord_profile_params
        params.require(:landlord_profile).permit(:first_name, :last_name, :email, :phone, :mailing_address)
    end
