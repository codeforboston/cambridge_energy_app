class UserMailer < ApplicationMailer
  def existing_user_invite_email(invitation)
    @user = User.find(invitation.receiver_id)
    @team = Team.find(invitation.sender_id)
    @mssg = invitation.mssg
    mail(to: invitation.email, subject: invite_message(invitation) + @team.name)
  end

  def new_user_invite_email(invitation)
    @team = Team.find(invitation.sender_id)
    @invitation.token = Digest::SHA1.hexdigest([@invitation.sender_id, Time.now, rand].join)
    @url = new_user_registration_path(:invitation_token => @invitation.token)
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
