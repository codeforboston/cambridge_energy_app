class Users::InvitationsController < Devise::InvitationsController

  # POST /resource/invitation
  def create
    @user = User.find_by(email: invite_params[:email])

    if @user && @user.email != current_user.email
      self.resource = invite_resource_and_skip
    else
      self.resource = invite_resource
    end

    super
  end

  protected

  def invite_resource_and_skip
    @user.invite!(current_user) do |u|
      # skip sending emails on invite
      u.skip_invitation = true
    end
    @user
  end
end
