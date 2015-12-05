class Landlord < ActiveRecord::Base
  has_many :city_buildings
  validates :first_name
  validates :last_name
  validates :email
  validates :phone
  validates :mailing_address
end
