class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :username, type: String, default: ''
  field :email, type: String, default: ''
  field :password_digest, type: String

  has_many :twitter_accounts
  has_many :facebook_accounts
  has_many :posts

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Must be a valid email' }

  def total_accounts
    twitter_accounts.count + facebook_accounts.count
  end

  def has_any_account?
    total_accounts > 0
  end
end
