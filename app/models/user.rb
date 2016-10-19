class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  belongs_to :unit
  belongs_to :team
  has_many :bills, dependent: :destroy
  has_many :user_tips, dependent: :destroy
  has_many :tips, through: :user_tips
  has_many :uploads, inverse_of: :user
  validates :phone, length: { is: 10 }, if: "phone?"
  validates :phone, numericality: { only_integer: true }, if: "phone?"

  after_invitation_accepted :accept_invite

  def area_code
    self.phone ? self.phone.slice(0,3) : nil
  end

  def exchange
    self.phone ? self.phone.slice(3,3) : nil
  end

  def line
    self.phone ? self.phone.slice(6,4) : nil
  end

  def phone_string
   self.phone.present? ? "#{self.area_code}-#{self.exchange}-#{self.line}" : ''
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def first_name_or_email
    return email_without_domain if first_name.nil? || first_name.empty?
    first_name
  end

  def score
    most_recent_bills = self.bills.last(2).map { |bill| bill.usage }
    most_recent_bills.length == 2 ? ((most_recent_bills[1] - most_recent_bills[0]) / most_recent_bills[0]) * 100 : 0
  end

  def most_recent_bills(number = 1)
    self.bills.last(number).map { |bill| bill.usage }
  end

  def tipset
    if self.tipnum.nil?
      self.tipnum = 0
      self.save()
    end
  end

  def after_database_authentication
    self.tipnum = rand(Tip.not_disliked(self).length)
    self.save()
  end

  def is_member?(team)
    self.try(:team).try(:id) == team.id
  end

  def invited?
    if self.invited_by_id
      return true if self.team_id != User.find(self.invited_by_id).team_id
    else
      false
    end
  end

  def inviter_name
    @inviter = User.find(self.invited_by_id)
    if @inviter.first_name && @inviter.last_name
      return "#{@inviter.first_name} #{@inviter.last_name}"
    else
      return @inviter.first_name_or_email
    end
  end

  def inviter_team
    @inviter = User.find(self.invited_by_id)
    @inviter.team if @inviter
  end

  def invite_existing(user)
    user.update(invited_by_id: self.id)
  end

  def accept_invite
    update_attributes(team_id: self.inviter_team.id, invited_by_id: nil)
  end

  def decline_invite
    update(invited_by_id: nil)
  end

  def process_unit(unit_params, user_is_guest)
    if user_is_guest && unit = self.unit # if user is guest and has a unit
      return reset_guest(unit, unit_params)
    elsif user_is_guest #if user is guest and does not have a unit
      return self.assign_new_unit(unit_params)
    elsif unit = self.unit # user is not guest and has unit
      return unit
    else # user is not guest and no unit
      return self.assign_new_unit(unit_params)
    end
  end

protected
  def assign_new_unit(params)
    unit = Unit.new(params)
    if unit.save
      self.update(unit: unit)
      return unit
    else
      return unit
    end
  end

  def reset_guest(current_unit, unit_params)
    bill = Bill.find_by(unit: current_unit)
    bill.delete if bill != nil # delete guest's previously entered bills
    self.update(unit: nil) # delete guest's previously entered unit
    current_unit.destroy
    return self.assign_new_unit(unit_params)
  end

private
  def email_without_domain
    email.split('@').first
  end
end
