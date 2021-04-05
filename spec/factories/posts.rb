FactoryBot.define do
  factory :post do
    user { create :user_with_many_accounts, tw_counter: 1, fb_counter: 1 }
    twitter_account { user.twitter_accounts[0] }
    sequence(:body) { |n| "Test post #{n}" }
    publish_at { DateTime.current + 7.days }
    post_id { nil }

    factory :published_post do
      post_id { '1372176407267250182' }
    end
  end
end
