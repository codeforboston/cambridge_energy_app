class Landlord < ActiveRecord::Base
  has_many :city_buildings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mailing_address, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
