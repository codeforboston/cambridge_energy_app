module UsersHelper

    def profile_complete_meter(user)
      tot = 0
      completeness = ""
      tot += 25 if user.first_name != ''
      tot += 25 if user.last_name != ''
      tot += 35 if user.street_address != ''
      tot += 15 if user.phone

      if tot < 100
        completeness = "only " + tot.to_s + " percent "
      end
      profile_complete_message = "Your profile is " + completeness + "complete!"
    end

    def devise_edit_user_path
      '/users/edit'
    end

    def edit_current_user_path
      '/users/me/edit'
    end

    def current_user_path
      '/users/me'
    end

end
