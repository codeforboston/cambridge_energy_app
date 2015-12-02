class User_Profile < ActiveRecord::Base
    validates :firstname
    validates :lastname
    validates :streetAddress, presence: true
    validates :unit_id
    validates :phone
    validates :email, presence: true
                                uniqueness: {true, message: "Email address already listed."}
    validates :team_id
end
