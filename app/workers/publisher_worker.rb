class PublisherWorker
  include Sidekiq::Worker

  def perform(id)
    post = Post.find(id)
    post.publish_post!
  end
end
