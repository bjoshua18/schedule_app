FactoryBot.define do
  factory :facebook_page do
    sequence(:name) { |n| "Facebook Page Test #{n}" }
    token { "XXXXXXXXXXXXXXXXX" }
    page_id { "9999999999999" }
    category { "Test Category" }
    facebook_account
  end
end
