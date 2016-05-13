class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:authorize_user, :authorize_receiver, :show, :edit, :update, :destroy, :join]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_receiver, only: :join
  
  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.where(receiver_id: current_user.id)
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params).prep(current_user)
    @team = Team.find(@invitation.sender_id)
    @receiver = User.find_by_email(@invitation.email)
    if @receiver
      @invitation.receiver_id = @receiver.id
    end
    respond_to do |format|
      if @invitation.save
        if @receiver
          UserMailer.existing_user_invite_email(@invitation).deliver_now
          message = 'Invitation sent to existing user'
        else
          UserMailer.new_user_invite_email(@invitation).deliver_now
          message = 'Invitation sent to new user'
        end
        format.html { redirect_to inviting_team_path(@team), notice: message }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @user = @invitation.receiver
    @team = @invitation.sender
    @invitation.destroy
    if @user == current_user
      respond_to do |format|
        format.html { render :index, notice: 'Invitation removed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html {redirect_to '/teams/' + @team.id.to_s + '/inviting', notice: 'Invitation removed.' }
        format.json { head :no_content }
      end
    end
  end

  def join
    @team = @invitation.sender
    @user = @invitation.receiver
    if @user.team_id
      respond_to do |format|
        format.html { redirect_to users_me_path, notice: 'You are already on a team' }
        format.json { render :show, status: :ok, location: @user }
      end
    else
      @user.team_id = @team.id
      @user.save
      @invitation.destroy
      respond_to do |format|
        format.html { redirect_to '/teams/' + @team.id.to_s, notice: 'Welcome to the team!' }
        format.json { render :show, status: :ok, location: @team }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    def authorize_user
      unless @invitation.sender.id == current_user.team_id || @invitation.receiver == current_user 
        flash[:error] = "You do not have permission."
        redirect_to users_me_path(current_user), notice: "Access denied."
      end
    end

    def authorize_receiver
      unless @invitation.receiver == current_user
        flash[:error] = "You do not have permission."
        redirect_to users_me_path(current_user), notice: "Access denied."
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(
        :email,
        :inviter_id,
        :receiver_id,
        :sender_id,
        :token,
        :mssg
      )
    end
end
