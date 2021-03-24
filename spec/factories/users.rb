FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test_user_#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password' }

    factory :user_with_many_accounts do
      transient do
        tw_counter { 5 }
        fb_counter { 5 }
      end

      after(:create) do |user, evaluator|
        user.twitter_accounts = create_list(:twitter_account, evaluator.tw_counter)
        user.facebook_accounts = create_list(:facebook_account, evaluator.fb_counter)
      end
    end
  end
end
