FactoryBot.define do
  factory :facebook_account do
    sequence(:name) { |n| "Facebook Test User #{n}" }
    sequence(:email) { |n| "facebooktestuser#{n}@test.com" }
    image { "http://graph.facebook.com/v4.0/352914279210567/picture?access_token=EAAGfx85ToPwBADhQfqkPdJllijcNdhl0zlihZAiIh028oGMaTSGEVLu3IiM4sAYzRe6VyPfCiapvKTYeSlWCS3lhOzEOZAFu7kWXsVZAFTOvnfqqKAjd6ywVI7T4gSqQItlMiAXOmcZATfujjBjHdfrhAoAB3qRD6aZA0tvBxik8hzJGGW6GZBfSgZAxDDBlSOVkecNJZBL0tQZDZD" }
    token { "EAAGfx85ToPwBADhQfqkPdJllijcNdhl0zlihZAiIh028oGMaTSGEVLu3IiM4sAYzRe6VyPfCiapvKTYeSlWCS3lhOzEOZAFu7kWXsVZAFTOvnfqqKAjd6ywVI7T4gSqQItlMiAXOmcZATfujjBjHdfrhAoAB3qRD6aZA0tvBxik8hzJGGW6GZBfSgZAxDDBlSOVkecNJZBL0tQZDZD" }
    token_expires_at { DateTime.current + 7.days }
    user
  end
end
