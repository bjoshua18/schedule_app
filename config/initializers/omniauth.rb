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
    # Permissions
    scope: 'email,public_profile,pages_manage_posts,
            pages_read_engagement'
  )
end