module PostsHelper
  def scheduled_posts
    Current.user.posts.where(tweet_id: nil).order_by(publish_at: 1)
  end

  def published_posts
    Current.user.posts.not_in(tweet_id: nil).order_by(publish_at: -1)
  end
end