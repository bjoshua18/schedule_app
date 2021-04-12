class FacebookPage < Publisher
  field :page_id, type: String
  field :category, type: String

  belongs_to :facebook_account

  def client
    Koala::Facebook::API.new(token)
  end

  def publish(post)
    fb_post = self.client.put_connections("me", "feed", {
      message: post.body
    })
    return fb_post["id"]
  end
end
