class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum customer_tier: %i[standard gold platinum]

  # Associations
  has_many :transactions
  has_many :products, through: :transactions, dependent: :destroy
  belongs_to :currency
  has_many :user_rewards
  belongs_to :reward

  # Validations
  validates :first_name, :last_name, :birthdate, presence: true
  validate :check_birthdate

  def check_birthdate
    self.birthdate > Date.today ?  errors.add(:birthdate, "cannot be greater than today's date") : nil
  end

  # returns the associated transactions that are created with same currency.
  def fetch_native_transactions
    transactions.where(currency_id: currency_id)
  end

  # returns the associated transactions that are created with foreign currency.
  def fetch_foreign_transactions
    transactions.where.not(currency_id: currency_id)
  end

  def calculate_reward_points
    # for transactions created with same currency
    native_points = (fetch_native_transactions.sum(:amount)/100).to_i * 10
    # for transactions created with foreign currency
    foreign_points = (fetch_foreign_transactions.sum(:amount)/100).to_i * 20
    # return total points of user
    native_points + foreign_points
  end
end
