FactoryBot.define do
  factory :facebook_account do
    sequence(:name) { |n| "Facebook Test User #{n}" }
    sequence(:email) { |n| "facebooktestuser#{n}@test.com" }
    image { "http://graph.facebook.com/testimage" }
    token { "XXXXXXXXXXXXXX" }
    token_expires_at { DateTime.current + 7.days }
    user
  end
end
