Rails.application.config.middleware.use OmniAuth::Builder do
  # Twitter
  provider(
    :twitter,
    Rails.application.credentials.dig(:twitter, :api_key),
    Rails.application.credentials.dig(:twitter, :api_secret)
  )
  # Facebook
  provider(
    :facebook,
    Rails.application.credentials.dig(:facebook, :api_key),
    Rails.application.credentials.dig(:facebook, :api_secret),
    scope: 'public_profile,email,pages_manage_posts,pages_read_engagement,pages_manage_ads,pages_manage_metadata,pages_show_list'
  )
end