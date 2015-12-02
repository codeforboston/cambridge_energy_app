class User_Profile < ActiveRecord::Base
    validates :first_name
    validates :last_name
    validates :street_address, presence: true
    validates :unit_id
    validates :phone
    validates :email, presence: true
                                uniqueness: {true, message: "Email address already listed."}
    validates :team_id
end
