class FacebookAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :image, type: String
  field :token, type: String
  field :token_expires_at, type: Time

  belongs_to :user
  has_many :posts

  validates :email, uniqueness: true

  def client
    Koala::Facebook::API.new(token)
  end
end
