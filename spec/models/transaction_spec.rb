require 'rails_helper'

describe Transaction do
  let (:user) { build :user }
  let (:product) { build :product }
  let (:currency) { build :currency }

  it "create valid transaction" do
    subject { create :transaction }
  end

  describe "add_transaction_details" do
    let(:quantity) { 5 }
    let(:transaction) {
      create :transaction, user: user, product: product, currency: currency, quantity: quantity
    }

    subject { transaction.add_transaction_details }
    context "if valid" do
      it {is_expected.to eq(true)}
    end
  end

  describe "update_user_points_and_status" do
    let(:quantity) { 5 }
    let(:transaction) {
      create :transaction, user: user, product: product, currency: currency, quantity: quantity
    }

    subject { transaction.update_user_points_and_status }
    context "if valid" do
      it {is_expected.to eq(true)}
    end
  end
end
