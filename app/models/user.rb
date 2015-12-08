class User < ActiveRecord::Base
  belongs_to :unit

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street_address, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :password, presence: true
  
end
