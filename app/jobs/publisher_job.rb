class PublisherJob < ApplicationJob
  queue_as :default

  def perform(post)
    return if post.published?
    # Reschedule a tweet to the future
    return if post.publish_at > Time.current

    if post.facebook?
      post.publish_to_facebook!
    else
      post.publish_to_twitter!
    end
  end
end
