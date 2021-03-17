FactoryBot.define do
  factory :twitter_account do
    name { "Byron Bustamante" }
    username { "byrondev" }
    image { "http://pbs.twimg.com/profile_images/1362493981775581184/By6QKkhM_normal.jpg" }
    token { "1362493740447842304-K3wiBLjZSzbKsWwzJXcVNhiKXxpSfO" }
    secret { "9SUdTu0oWSXhLJEx65b8rnoUU7Gl9gdTh6r730w2Imvzv" }
    user
  end
end
