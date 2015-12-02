class Profile < ActiveRecord::Base
    validates :streetAddress, presence: true,
                                format: { with: REGEXP , message: "Not valid street address." },
                                uniqueness: {true, message: "Street address already listed."}
    validates :emailAddress, presence: true,
                                format: { with: REGEXP, message: "Not valid email address." },
                                uniqueness: {true, message: "Email address already listed."}
    validates :buildingType, presence: true
    validates :numberUnitsInBuilding, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :householdSize, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :energyType, presence: true
    validates :heatType, presence: true
end
