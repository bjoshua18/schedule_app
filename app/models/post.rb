class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :body, type: String
  field :publish_at, type: Time
  field :post_id, type: String
  field :facebook_account_page, type: Integer

  index({publish_at: -1})

  belongs_to :user
  belongs_to :twitter_account, optional: true
  belongs_to :facebook_account, optional: true

  validates :body, length: { minimum: 1, maximun: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 1.minute.from_now
  end
  
  after_save do
    if publish_at_previously_changed?
      PublisherJob.set(wait_until: publish_at).perform_later(self)
    end
  end

  def published?
    post_id?
  end

  def facebook?
    facebook_account_page?
  end

  def publish_to_twitter!
    tweet = twitter_account.client.update(body)
    update(post_id: tweet.id)
  end

  def publish_to_facebook!
    pages = facebook_account.pages
    page = Koala::Facebook::API.new(pages[facebook_account_page]["access_token"])
    fb_post = page.put_connections("me", "feed", {
      message: body
    })
    update(post_id: fb_post["id"])
  end
end
