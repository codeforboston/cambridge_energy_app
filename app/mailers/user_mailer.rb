class UserMailer < ApplicationMailer
    
    def team_invite_email(team, user, url)
        @user = user
        @team = team
        @join_url = url
        mail(to: @user.email, subject: "EnerSave: You've been invited to join team " + @team.name)
    end
end
