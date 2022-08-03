FactoryBot.define do
  factory :transaction do
    user { build_stubbed(:user) }
    currency { build_stubbed(:currency) }
    product { build_stubbed(:product) }
    quantity { 5 }
    amount { product.price * quantity }
  end
end
