class UserController < ApplicationController
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
    
        if @user.save
            redirect_to @user
        else 
            render 'new'
        end
    end    
    
    def show
        @user = User.find(params[:id])
    end

private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :street_address, :unit_id, :phone, :email, :team_id, :password)
    end
