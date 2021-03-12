class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Current.user.posts.order_by(publish_at: 1)
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
    @post.destroy
    redirect_to posts_url, notice: 'Post was unscheduled'
  end

  private

    def post_params
      params.require(:post).permit(:twitter_account_id, :body, :publish_at)
    end

    def set_post
      @post = Current.user.posts.find_by(id: params[:id])
    end
end