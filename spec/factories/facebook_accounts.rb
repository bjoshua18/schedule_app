FactoryBot.define do
  factory :facebook_account do
    name { "Byron Bustamante" }
    sequence(:email) { |n| "byrondevweb#{n}@gmail.com" }
    image { "http://graph.facebook.com/v4.0/352914279210567/picture?access_token=EAAxleBttZCqcBAI6O6cZAsJZAygF5xjjnCyCBVFAzWmCuoX1xqkTP2x0el4GNX2cUIPQ1P4ISQ2hOQPED8TAyCajP45rZCIcRPoK3x7dKYon1CYeL6TmC1QylsnY2Q1v4sbkSKgfb6SelhwrRaZAO3uAi5egrPiBZCbEGZCZA767FtPNPdRijwal" }
    token { "EAAxleBttZCqcBAI6O6cZAsJZAygF5xjjnCyCBVFAzWmCuoX1xqkTP2x0el4GNX2cUIPQ1P4ISQ2hOQPED8TAyCajP45rZCIcRPoK3x7dKYon1CYeL6TmC1QylsnY2Q1v4sbkSKgfb6SelhwrRaZAO3uAi5egrPiBZCbEGZCZA767FtPNPdRijwal" }
    token_expires_at { DateTime.current + 7.days }
    user
  end
end
