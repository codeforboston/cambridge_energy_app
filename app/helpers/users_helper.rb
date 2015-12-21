module UsersHelper
  
    def profile_complete_meter(user)
      tot = 0
      if user.first_name 
        tot += 25 
      end #add verification for formatting?
      if user.last_name 
        tot += 25 
      end
      if user.street_address 
        tot += 35 
      end
      if user.phone 
        tot += 15
      end
    end
    
end
