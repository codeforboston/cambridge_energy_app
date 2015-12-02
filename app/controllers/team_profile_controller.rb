class Team_ProfileController < ApplicationController
    
    def new
        @team_profile = Team_Profile.new
    end
    
    def create
        @team_profile = Team_Profile.new(profile_params)
    
        if @team_profile.save
            redirect_to @team_profile
        else 
            render 'new'
        end
    end    
    
    def show
        @team_profile = Team_Profile.find(params[:id])
    end

private
    def team_profile_params
        params.require(:team_profile).permit(:name)
    end
