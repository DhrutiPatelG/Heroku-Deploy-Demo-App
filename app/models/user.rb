class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum customer_tier: %i[standard gold platinum]

  # Associations
  has_many :transactions
  has_many :products, through: :transactions
  belongs_to :currency

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validate :check_birthdate

  def check_birthdate
    self.birthdate > Date.today ?  errors.add(:birthdate, "cannot be greater than today's date") : nil
  end

  def self.standard?
    user.customer_tier == "standard"
  end

  def self.gold?
    user.customer_tier == "gold"
  end

  def self.platinum?
    user.customer_tier == "platinum"
  end
end
