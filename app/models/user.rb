class User < ActiveRecord::Base
  belongs_to :unit
  belongs_to :team
end
