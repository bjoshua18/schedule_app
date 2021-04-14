FactoryBot.define do
  factory :post do
    user { create :user_with_many_accounts, tw_counter: 1, fb_counter: 1 }
    publisher { user.twitter_accounts[0] }
    sequence(:body) { |n| "Test post #{n}" }
    publish_at { DateTime.current + 7.days }
    post_id { nil }

    factory :published_post do
      post_id { '1372176407267250182' }
    end

    factory :post_with_image do
      image { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/posts/page_flow.png'), 'image/png') }
    end
  end
end
