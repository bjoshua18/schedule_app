FactoryBot.define do
  factory :publisher do
    sequence(:name) { |n| "Publisher Test #{n}" }
    token { "XXXXXXXXXXXXXXXXX" }
  end
end
