class UserMailerPreview < ActionMailer::Preview
    def team_invite_email_preview
        UserMailer.team_invite_email(Team.first, User.first)
    end
end