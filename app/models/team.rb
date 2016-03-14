class Team < ActiveRecord::Base
  has_many :users
  has_many :invitations, foreign_key: "sender_id", dependent: :destroy
  has_many :receivers, through: :invitations
end
