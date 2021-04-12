class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :include_fb_pages, only: [:new, :create, :update]

  def index
    @posts = Current.user.posts.order_by(publish_at: -1)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.create(post_params)

    if @post.save
      redirect_to posts_url, notice: 'Post was scheduled successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_url, notice: 'Post was updated successfully'
    else
      render :edit
    end
  end

  def destroy
    if @post
      notice = @post.destroy ? 'Post was unscheduled' : 'Something was wrong'
    end
    redirect_to posts_url, notice: notice || 'Post not found'
  end

  private

    def post_params
      params.require(:post).permit(:publisher_id, :body, :publish_at)
    end

    def set_post
      @post = Current.user.posts.find_by(id: params[:id])
    end

    def include_fb_pages
      Current.user.facebook_accounts.each do |acc|
        acc["pages"] = acc.facebook_pages
      end
    end
end