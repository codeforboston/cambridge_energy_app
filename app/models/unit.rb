class Unit < ActiveRecord::Base
  belongs_to :user_building
  has_many :users
end
