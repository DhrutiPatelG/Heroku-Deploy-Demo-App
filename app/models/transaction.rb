class Transaction < ApplicationRecord

  # Associations
  belongs_to :currency
  belongs_to :user
  belongs_to :product

  # Callbacks
  before_commit :add_transaction_details, :update_user_points_and_status

  def add_transaction_details
    self.amount = product.price * quantity
    self.value = "#{currency.code}" + "#{amount.to_f}"
    self.save!
  end

  def update_user_points_and_status

    # update points as if transaction is greater than 100
    if self.amount >= 100
      points = calculate_points(user.currency == currency)
      user.points = user.points.to_f + points
    end

    # update customer-tier according to the points
    user.customer_tier =
      case user.points
      when 0..999
        "standard"
      when 1000..4999
        user.airport_lounge_reward = true
        "gold"
      else
        "platinum"
      end
    user.save!
  end

  def calculate_points(same_currency)
    # check if transaction is made in same currency as the user is registered
    # if both are same; add 10 points, else double the points
    same_currency ? (amount/100).to_i * 10 : (amount/100).to_i * 20
  end
end
