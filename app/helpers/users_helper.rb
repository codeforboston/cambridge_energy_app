module UsersHelper

    def profile_complete_meter(user)
      tot = 0
      completeness = ""
      tot += 25 unless user.first_name.nil? || user.first_name.empty?
      tot += 25 unless  user.last_name.nil? || user.last_name.empty?
      tot += 35 unless user.street_address.nil? || user.street_address.empty?
      tot += 15 unless user.phone.nil? || user.phone.empty?

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
