class Team < ActiveRecord::Base
  validates :name, uniqueness: true
end

#connection to user not via Rails associated has/belongs_to system, as that seems to require that the teams exist before the users do. 
#also makes resource routing a mess.
#maybe fix later.
