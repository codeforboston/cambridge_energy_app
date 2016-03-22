class Bill < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  accepts_nested_attributes_for :unit

  validate :bill_received_is_date?
  validates :bill_received, presence: true
  validates :amount, presence: true, numericality: true, inclusion: {in: [0, 9999]}

  def bill_received_is_date?
    unless bill_received.is_a?(Date)
      errors.add(:bill_received, 'must be a valid date')
    end
  end

end
