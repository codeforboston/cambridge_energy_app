class UserTip < ActiveRecord::Base
  belongs_to :user
  belongs_to :tip

  validates :user, presence: true
  validates :result, presence: true
  validates :tip, presence: true
  validates_uniqueness_of :user_id, :scope => [:tip_id]
end
