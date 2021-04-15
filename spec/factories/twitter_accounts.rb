FactoryBot.define do
  factory :twitter_account do
    sequence(:name) { |n| "Twitter Test User #{n}" }
    sequence(:username) { |n| "twittertestuser#{n}" }
    image { "http://pbs.twimg.com/profile_images/testimage" }
    token { "XXXXXXXXXXXXXXX" }
    secret { "YYYYYYYYYYYYYY" }
    user
  end
end
