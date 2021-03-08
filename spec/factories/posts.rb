FactoryBot.define do
  factory :post do
    user { nil }
    body { "MyText" }
    publish_at { "2021-03-05 16:38:43" }
    tweet_id { "MyString" }
  end
end
