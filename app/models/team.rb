class Team < ActiveRecord::Base
  # == Associations
  has_many :users
  has_many :receivers, through: :invitations

  # == Validations
  validates :name, presence: true

  # == Scope methods
  scope :with_users, -> { includes(:users).select{ |team| team.users.length > 0 }}
  scope :by_score, -> { with_users.sort_by(&:score).reverse }

  # == Instance methods
  def score
    bills = self.users.map { |user| user.most_recent_bills }
    bills.reject { |score| !score.kind_of?(Array) | (score.length < 2) }
    this_month_bills = []
    last_month_bills = []
    bills.each do |score|
      last_month_bills << score[0]
      this_month_bills << score[1]
    end
    this_month_total = this_month_bills.reduce(:+)
    last_month_total = last_month_bills.reduce(:+)

    if this_month_total && last_month_total
      ((last_month_total - this_month_total) / last_month_total)
    else
      0
    end
  end
end
