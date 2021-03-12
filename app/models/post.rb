class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :publish_at, type: Time
  field :tweet_id, type: String

  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximun: 280 }
  validates :publish_at, presence: true #, timeliness: { type: :datetime, after: :now }

  after_initialize do
    self.publish_at ||= 1.minute.from_now
  end
  
  after_save do
    if publish_at_previously_changed?
      PublisherJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    tweet_id?
  end

  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    # tweet = twitter_account.client.update_with_media(body, File.new(Rails.root.join('app', 'assets', 'images', 'page_flow.png')))
    update(tweet_id: tweet.id)
  end
end
