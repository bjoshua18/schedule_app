FactoryBot.define do
  factory :facebook_page do
    sequence(:name) { |n| "Facebook Page Test #{n}" }
    token { "EBBGfx85ToPwBADhQfqkPdJllijcNdhl0zlihZAiIh028oGMaTSGEVLu3IiM4sAYzRe6VyPfCiapvKTYeSlWCS3lhOzEOZAFu7kWXsVZAFTOvnfqqKAja6ywVI7T4gSqQItlMiyXOmcZATfujjBjHdfrhAoAB3qRD64ZA0tvBxik8hzJGGW6GZBfSgZAxDDBlSOVkecNJZBL0tQZDZD" }
    page_id { "74854785495448584994" }
    category { "Test Category" }
    facebook_account
  end
end
