class PublisherJob < ApplicationJob
  queue_as :default

  def perform(post)
    return if post.published?
    # Reschedule a tweet to the future
    return if post.publish_at > Time.current

    post.publish_to_twitter!
  end
end
