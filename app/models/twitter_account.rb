class TwitterAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :image, type: String
  field :token, type: String
  field :secret, type: String

  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :username, uniqueness: true

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.dig(:twitter, :api_key)
      config.consumer_secret = Rails.application.credentials.dig(:twitter, :api_secret)
      config.access_token = token
      config.access_token_secret = secret
    end
  end
end
