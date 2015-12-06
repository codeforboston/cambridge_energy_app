class UserController < ApplicationController
    
    #Whenever a new user is created, need to make sure that the unit and building for them exists, and if not create them from the data given.
    
    @user_building = UserBuilding.find(params[:user_building_id])
    
    def index
        @user = @user_building.users.all
    end
    
    def show
        @user = @user_building.users.find(params[:id])
    end
    
    def new
        @user = @user_building.users.new
    end
    
    def edit
        @user = @user_building.users.find(params[:id])
    end
    
    def create
        @user = @user_building.users.create(user_params)
        @redirect_to user_building_path(@user_building)
    end 

    def update
        
        @user = @user_building.users.find(params[:id])
        
        if user.update(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        @user = @user_building.users.find(params[:id])
        @user.destroy
        redirect_to user_building_path(@user_building)
private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :street_address, :phone, :email, :password)
    end
