class UsersController < ApplicationController
  before_action :set_user
  before_action :authorize_user

  def show
  end

  def edit
    @area = @user.area_code
    @exchange = @user.exchange
    @line = @user.line
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { render :show, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = current_or_guest_user
    end

    def authorize_user
      authorize @user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :image)
    end

end
