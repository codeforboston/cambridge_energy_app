require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
    test "Invite" do
        @teampick = Team.select { |team| team.id == 7 }
        @team = @teampick.first
        @userpick = User.select { |user| user.id == 2 }
        @user = @userpick.first
        email = UserMailer.team_invite_email(@team,@user).deliver_now
        assert_not ActionMailer::Base.deliveries.empty?
        
        assert_equal ['talovantor@gmail.com'], email.from
        assert_equal ['exohedron@gmail.com'], email.to
    end
end