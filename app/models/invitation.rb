class Invitation < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "Team"
  belongs_to :inviter, class_name: "User"
  
  def prep(user)
    self.inviter = user
    self.email = self.email.downcase! || self.email
    return self
  end
end
