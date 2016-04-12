class UserMailer < ApplicationMailer
    
     def existing_user_invite_email(invitation)
        @user = User.find(invitation.receiver_id)
        @team = Team.find(invitation.sender_id)
        #@inviter = User.find(invitation.inviter)
        mail(to: invitation.email, subject: "EnerSave: " + "@inviter.first_name" + " " + "@inviter.last_name" + " invites you to join team " + @team.name)
    end
    
    def new_user_invite_email(invitation, url)
        @team = Team.find(invitation.sender_id)
        #@url = application_url
        #@inviter = User.find(id: invitation.inviter)
        mail(to: invitation.email, subject: "EnerSave: " + "@inviter.first_name" + " " + "@inviter.last_name" + " invites you to join team " + @team.name)
    end
    
end
