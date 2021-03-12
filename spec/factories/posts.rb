FactoryBot.define do
  factory :post do
    user
    twitter_account { user.twitter_account }
    sequence(:body) { |n| "Test post #{n}" }
    publish_at { Datetime.current + 7.days }
    tweet_id { nil }
  end
end
