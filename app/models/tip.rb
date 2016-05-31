class Tip < ActiveRecord::Base
  has_many :user_tips, dependent: :destroy
  has_many :users, through: :user_tips

  def liked_votes
    return UserTip.select { |usertip| usertip.tip.id == self.id && usertip.result == "Liked" }.length
  end

  def disliked_votes
    return UserTip.select { |usertip| usertip.tip.id == self.id && usertip.result == "Disliked" }.length
  end

  def self.not_disliked(user)
    @user = user
    return Tip.select { |tip| tip.user_tips.find_by(user_id: @user.id, result: "Disliked").nil? }
  end

  def self.get_tip(user)
    if Tip.not_disliked(user).length > 0
      return Tip.not_disliked(user)[user.tipnum]
    end
  end
  
  def self.next_tip(user)
    @user = user
    @number_of_tips = Tip.not_disliked(user).length
    user.tipnum = ((user.tipnum + 1 + rand(@number_of_tips/2)) % @number_of_tips)
    user.save()
  end
  
end
