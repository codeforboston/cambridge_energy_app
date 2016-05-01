class RegistrationsController < Devise::RegistrationsController
  def create
    super
    current_or_guest_user
  end

  def after_sign_up_path_for(user)
    'teams/leaderboard'
  end
end

