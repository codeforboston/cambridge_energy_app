class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy, :check_user_existence
  ]

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all
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
    @invitation = Invitation.new(invitation_params)
    # @invitation.inviter = current_user.id
    @invitation.token = Digest::SHA1.hexdigest([@invitation.sender_id, Time.now, rand].join)
    @team = Team.find(@invitation.sender_id)
    receiver = User.find_by_email(@invitation.email)
    if receiver
      @invitation.receiver_id = receiver.id
    end
    respond_to do |format|
      if @invitation.save
        if receiver
          UserMailer.existing_user_invite_email(@invitation).deliver
          message = 'Invitation sent to existing user'
        else
          UserMailer.new_user_invite_email(@invitation, new_user_registration_path(:invitation_token => @invitation.token)).deliver
          message = 'Invitation sent to new user'
        end
        format.html { redirect_to @team, notice: message }
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
    @team = Team.find(@invitation.sender_id)
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to inviting_team_path(@team), notice: 'Invitation removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:email, :inviter, :receiver_id, :sender_id, :token)
    end
end
