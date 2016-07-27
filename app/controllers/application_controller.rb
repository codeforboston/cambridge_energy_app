class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # include Pundit
  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

  # rescue_from Pundit::NotAuthorizedError do |exception|
  #   Rails.logger.debug "Access denied on #{exception.query} #{exception.policy}"
  #   render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  # end

 # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry: false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry: true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def after_sign_in_path_for(user)
    leaderboard_teams_path
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # Transfer guest unit, team, and bills to the new user account
    current_user.update(unit: guest_user.unit, team: guest_user.team)

    guest_user.bills.each do |bill|
      bill.update(user: current_user, unit: current_user.unit)
    end

    # Reload the cache to prevent deleting bill in the next step
    guest_user.bills(true)
    current_user.bills(true)
  end

  def create_guest_user
    u = User.create(:first_name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
