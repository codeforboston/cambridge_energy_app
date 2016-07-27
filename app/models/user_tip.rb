class UserTip < ActiveRecord::Base
  belongs_to :user
  belongs_to :tip

  validates :user, presence: true
  validates :tip, presence: true
  validates :result, presence: true
  
end
