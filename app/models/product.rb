class Product < ApplicationRecord

  # Associations
  has_many :transactions
  has_many :users, through: :transactions, dependent: :destroy

  enum category: %i[stationary gadget]
end
