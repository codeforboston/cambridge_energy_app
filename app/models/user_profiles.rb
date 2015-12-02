class User_Profile < ActiveRecord::Base
    validates :streetAddress, presence: true,
                                format: { with: REGEXP , message: "Not valid street address." },
                                uniqueness: {true, message: "Street address already listed."} %street address of user
    validates :aptNumber
    validates :emailAddress, presence: true,
                                format: { with: REGEXP, message: "Not valid email address." },
                                uniqueness: {true, message: "Email address already listed."} %email address of user
    validates :team_ID
end
