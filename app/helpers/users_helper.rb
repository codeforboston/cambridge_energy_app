module UsersHelper

    def profile_complete_meter(user)
      tot = 0
      completeness = ""
      tot += 25 if user.first_name
      tot += 25 if user.last_name
      tot += 35 if user.street_address
      tot += 15 if user.phone

      if tot < 100
        completeness = "only " + tot + " percent "
      end
      profile_complete_message = "Your profile is " + completeness + "complete!"
    end

end
