class Landlord < ActiveRecord::Base
  validates :first_name
  validates :last_name
  validates :email
  validates :phone
  validates :mailing_address
end
