Koala.configure do |config|
  config.app_id = Rails.application.credentials.dig(:facebook, :api_key)
  config.app_secret = Rails.application.credentials.dig(:facebook, :api_secret)
end