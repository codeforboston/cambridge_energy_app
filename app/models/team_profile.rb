class Team_Profile < ActiveRecord::Base
  validates :name, Uniqueness: true
end
