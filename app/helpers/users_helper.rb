module UsersHelper

    def profile_complete_meter(user)
      complete_percentage = 0
      complete_percentage += 25 unless user.first_name.nil? || user.first_name.empty?
      complete_percentage += 25 unless  user.last_name.nil? || user.last_name.empty?
      complete_percentage += 35 if user.unit.present?
      complete_percentage += 15 unless user.phone.nil? || user.phone.empty?

      complete_percentage
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
