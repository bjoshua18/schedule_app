FactoryBot.define do
  factory :publisher do
    sequence(:name) { |n| "Publisher Test #{n}" }
    token { "EJJGfx85ToPwBADhQfqkPdJllijcNdhl0zlihZAiIh028oGMaTSGEVLu3IiM4sAYzRe6VyPfCiapvKTYeSlWCS3lhOzEOZAFu7kWXsVZAFTOvnfqqKAja6ywVI7T4gSqQItlMiyXOmcZAThujjBjHdfrhAoAB3qRD64ZA0tvBxik7hzJGGW6GZBfSgZA78DBlSOVkecNJZBL0tQZDZD" }
  end
end
