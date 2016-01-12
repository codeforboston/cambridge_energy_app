class UserMailer < ApplicationMailer

  def team_invite_email(team, user)
    @user = user
    @team = team
    @url = '' #Need team joining url
    mail(to: @user.email, subject: "EnerSave: You've been invited to join team" + @team.name)
  end
end
