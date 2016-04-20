class UserMailer < ApplicationMailer
  def existing_user_invite_email(invitation)
    @user = User.find(invitation.receiver_id)
    @team = Team.find(invitation.sender_id)
    @mssg = invitation.mssg
    mail(to: invitation.email, subject: invite_message(invitation) + @team.name)
  end

  def new_user_invite_email(invitation, url)
    @team = Team.find(invitation.sender_id)
    #@url = application_url
    @mssg = invitation.mssg
    mail(to: invitation.email, subject: invite_message(invitation) + @team.name)
  end

  def invite_message(invitation)
    @invitation = invitation
    @inviter = invitation.inviter
    if @inviter.first_name && @inviter.last_name
      "EnerSave: #{@inviter.first_name} #{@inviter.last_name} invites you to join team "
    else
      "EnerSave: You've been invited to join team "
    end
  end
end
