class Invitation < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "Team"
  belongs_to :inviter, class_name: "User"
end
