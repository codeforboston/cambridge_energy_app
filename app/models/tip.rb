class Tip < ActiveRecord::Base
  has_many :user_tips, dependent: :destroy
  has_many :users, through: :user_tips

  def worked_votes
    return UserTip.select { |usertip| usertip.tip.id == self.id && usertip.result == "Worked" }.length
  end

  def failed_votes
    return UserTip.select { |usertip| usertip.tip.id == self.id && usertip.result == "Failed" }.length
  end

  def skipped_votes
    return UserTip.select { |usertip| usertip.tip.id == self.id && usertip.result == "Skipped" }.length
  end
  
end
