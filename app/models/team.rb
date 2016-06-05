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
    total_score = users.map{ |u| u.score }.sum

    (total_score / users.length).to_i
  end
end
