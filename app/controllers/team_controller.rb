class TeamController < ApplicationController
    
    def index
        @team = Team.all
    end

    def show
        @team = Team.find(params[:id])
    end

    def new
        @team = Team.new
    end

    def edit
        @team = Team.find(params[:id])
    end

    def create
        @team = Team.new(team_params)
    
        if @team.save
            redirect_to @team
        else 
            render 'new'
        end
    end

    def update
        @team = Team.find(params[:id])
    
        if team.update(team_params)
            redirect_to @team
        else
            render 'edit'
        end
    end

    def destroy
        
        @object = Object.find(params[:id])
        @object.destroy
    
        redirect_to objects_path

    private
        def team_params
            params.require(:team).permit(:name)
        end
