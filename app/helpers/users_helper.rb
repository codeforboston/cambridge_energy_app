module UsersHelper
  
    def profile_complete_meter(user)
      tot = 0
      completeness = ""
      if user.first_name do tot += 25 end end #add verification for formatting?
      if user.last_name do tot += 25 end end
      if user.street_address do tot += 35 end end
      if user.phone do tot += 15 end end
      if tot < 100 do completeness = "only " + tot + " percent " end end
      profile_complete_message = "Your profile is " + completeness + "complete!"
    end
    
end
