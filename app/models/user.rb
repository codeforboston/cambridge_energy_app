class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :first_name, length: { maximum: 50 }
    validates :last_name, length: { maximum: 50 }
    validates :street_address, presence: true
    validates :unit_id
    validates :phone
    validates :email, presence: true, length: { maximum: 255 }
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
                      uniqueness: { case_sensitive: false }
    validates :team_id
    validates :password, presence: true
end
