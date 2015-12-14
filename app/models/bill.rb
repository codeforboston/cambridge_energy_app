class Bill < ActiveRecord::Base
  belongs_to :user
  has_one :unit, through: :user
  accepts_nested_attributes_for :unit
end