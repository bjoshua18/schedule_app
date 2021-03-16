FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test_user_#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password' }
  end
end
