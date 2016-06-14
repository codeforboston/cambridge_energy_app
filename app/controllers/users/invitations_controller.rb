class Users::InvitationsController < Devise::InvitationsController

  # POST /resource/invitation
  def create
    user = User.find_by(email: invite_params[:email])
    if user && user.email != current_user.email
      if user.team_id != current_user.team_id
        current_user.invite_existing(user)
        flash[:notice] = "#{user.first_name_or_email} has been invited to join your team!"
      else
        flash[:notice] = "#{user.first_name_or_email} is already on your team!"
      end
      respond_with user, :location => after_invite_path_for(user)
    else
      super
    end
  end
end
