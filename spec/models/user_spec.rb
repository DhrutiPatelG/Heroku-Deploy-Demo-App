require 'rails_helper'

describe "create user" do

  let (:currency) { build :currency }

  it "check validation on user creation" do
    build :user
  end

  describe "check_birthdate" do
    let(:user) {
      create :user, currency: currency
    }

    subject { user.check_birthdate }

    context "if valid" do
      it {is_expected.to eq(nil)}
    end
  end
end
