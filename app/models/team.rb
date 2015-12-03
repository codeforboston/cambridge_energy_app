class Team < ActiveRecord::Base
  validates :name, uniqueness: true
end
