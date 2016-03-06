class SessionsController < Devise::SessionsController
  def create
    super
    current_or_guest_user
  end
end
