class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :publish_at, type: Time
  field :tweet_id, type: String

  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximun: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 1.minute.from_now
  end

  def published?
    tweet_id?
  end
end
