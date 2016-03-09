module TeamsHelper

  def leave(team)
    @team = team
    @user = current_user
    @user.team = nil
    @user.save
    if @team.users.length == 0
      @team.destroy
    end
  end
  
end
