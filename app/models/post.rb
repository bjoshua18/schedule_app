class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :post_id, type: String
  field :body, type: String
  field :publish_at, type: Time

  index({publish_at: -1})

  belongs_to :user
  belongs_to :publisher

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

  def publish_post!
    id = publisher.publish(self)
    update(post_id: id)
  end
end
