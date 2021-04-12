module PostsHelper
  def scheduled_posts
    Current.user.posts.where(post_id: nil).order_by(publish_at: 1)
  end

  def published_posts
    Current.user.posts.not_in(post_id: nil).order_by(publish_at: -1)
  end
end