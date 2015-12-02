class Profile < ActiveRecord::Base
    validates :streetAddress, presence: true,
                                format: { with: REGEXP , message: "Not valid street address." },
                                uniqueness: {true, message: "Street address already listed."} //street address of user
    validates :emailAddress, presence: true,
                                format: { with: REGEXP, message: "Not valid email address." },
                                uniqueness: {true, message: "Email address already listed."} //email address of user
    validates :buildingType, presence: true //apartment versus house versus condo
    validates :numberUnitsInBuilding, presence: true, numericality: {only_integer: true, greater_than: 0} //for cea incentives
    validates :householdSize, presence: true, numericality: {only_integer: true, greater_than: 0} //number of people in household
    validates :heatType, presence: true //what energy source used to heat
end
