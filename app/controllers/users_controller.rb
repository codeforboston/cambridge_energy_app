class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end
  
   # Show invitations
  def invitation
      @invitations = @user.invitations
  end
  
  # Join team
  def join
    @invitation = Invitation.find(:invitation_id)
    @team = Team.find(@invitation.sender_id)
    if @user.team_id 
      message = 'You are already on a team; you need to leave it first'
    else
      @user.team_id = @team.id
      @invitation.destroy
      message = 'You have successfully joined team ' + @team.name
      @user.save
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: message }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  private

    def set_user
      @user = current_or_guest_user
    end

end
