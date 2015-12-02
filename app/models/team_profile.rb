class Team_Profile < ActiveRecord::Base
  validates :name, uniqueness: true
end
