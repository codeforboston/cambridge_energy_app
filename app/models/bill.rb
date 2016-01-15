class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  accepts_nested_attributes_for :unit
end