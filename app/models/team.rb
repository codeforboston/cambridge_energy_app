class Team < ActiveRecord::Base
  has_many :users
  has_many :invitations, foreign_key: "sender_id", dependent: :destroy
  has_many :receivers, through: :invitations

  def score
    tot = 0
    self.users.each do |user|
      tot += user.score
    end
    return (tot/self.users.length).to_i
  end

  def self.sorted_by_score
    Team.select{ |team| team.users.length > 0 }.sort_by(&:score).reverse
  end

end
