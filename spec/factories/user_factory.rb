FactoryBot.define do
  factory :user do
    first_name {"Test"}
    last_name {"User"}
    email {"test@user.com"}
    birthdate { "1985/03/03" }
    password {"password"}
    currency { create(:currency) }
  end
end
