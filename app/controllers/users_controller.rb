class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :invitation, :join]
  require 'date'
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @teams = Team.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # Show invitations
  def invitation
      @invitations = @user.invitations
  end
  
  # Join team
  def join
    @invitation = Invitation.find(params[:invitation_id])
    @team = Team.select { |team| team.id == @invitation.sender_id }
    if @user.team_id 
      message = 'You are already on a team; you need to leave it first'
    else
      @user.team_id = @team.id
      Invitation.find(params[:invitation_id]).destroy
      message = 'You have successfully joined team ' + @team.name
      @user.save
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: message }
      format.json { render :show, status: :ok, location: @user }
    end
  end
  
  # Leave team
  def leave
    respond_to do |format|
      @user.team_id = 0
      @user.save
      format.html { redirect_to :show, notice: 'You have left the team.'}
      format.json { render :show, status: :ok, location: @user }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :street_address, :phone, {unit_ids: []}, :team_id)
    end
end
