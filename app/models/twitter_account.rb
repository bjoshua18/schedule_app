class TwitterAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :username, type: String
  field :image, type: String
  field :token, type: String
  field :secret, type: String

  belongs_to :user

  validates :username, uniqueness: true
end
