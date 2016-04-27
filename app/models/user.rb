class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  belongs_to :unit
  belongs_to :team
  has_many :bills, dependent: :destroy
  has_many :invitations, foreign_key: "receiver_id", dependent: :destroy
  has_many :senders, through: :invitations

  validates :phone, length: { is: 10 }, if: "!phone.nil?"
  validates :phone, numericality: { only_integer: true }

  def area_code
    self.phone.slice(0,3)
  end

  def exchange
    self.phone.slice(3,3)
  end

  def line
    self.phone.slice(6,4)
  end

  def phone_string
    "#{self.area_code}-#{self.exchange}-#{self.line}"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
