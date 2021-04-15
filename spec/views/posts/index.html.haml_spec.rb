require 'rails_helper'

RSpec.describe "posts/index.html.haml", type: :view do
  context 'user without accounts' do
    let(:user) { create :user }
    before(:each) do
      Current.user = user
      @posts = user.posts.page(params[:page])
      render
    end

    it 'render new_account_btns' do
      expect(response).to render_template 'shared/_new_account_btns'
    end

    it 'not render posts' do
      expect(response).not_to render_template 'posts/_post'
    end
  end

  context 'user with accounts but no posts' do
    let(:user) { create :user_with_many_accounts, tw_counter: 1 }
    before(:each) do
      Current.user = user
      @posts = user.posts.page(params[:page])
      render
    end

    it 'not render new_account_btns' do
      expect(response).not_to render_template 'shared/_new_account_btns'
    end

    it 'not render posts' do
      expect(response).not_to render_template 'posts/_post'
    end
  end

  context 'user with more than 2 posts' do
    let(:user) { create :user_with_many_accounts, tw_counter: 1 }
    let(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/posts/page_flow.png'), 'image/png') }
    let(:posts) { create_list :post, 5, user: user, image: image }
    before(:each) { Current.user = user }

    it 'render posts' do
      @posts = user.posts.page(params[:page])
      render
      expect(response).to render_template 'posts/_post'
      expect(response).to render_template 'kaminari/_page'
      expect(response).to render_template 'kaminari/_next_page'
      expect(response).to render_template 'kaminari/_paginator'
    end

    describe 'render a scheduled post' do
      let(:scheduled_post) { create :post, user: user, image: image }

      it 'render post-btns' do
        render scheduled_post
        expect(response).to render_template 'posts/_post'
        expect(response.body).to include 'post-btns'
        expect(response.body).not_to include 'ago'
      end
    end

    describe 'render a published post' do
      let(:published_post) { create :published_post, user: user, image: image }

      it 'render time_ago and link_to tweet' do
        render published_post
        expect(response).to render_template 'posts/_post'
        expect(response.body).to include 'View Tweet'
        expect(response.body).not_to include 'Scheduled for'
      end
    end
  end

  context 'user with 2 posts or less' do
    let(:user) { create :user_with_many_accounts, tw_counter: 1 }
    let(:posts) { create_list :post, 2, user: user }
    before(:each) { 
      Current.user = user 
      user.posts = posts
    }

    it 'render posts' do
      @posts = user.posts.page(params[:page])
      render
      expect(response).to render_template 'posts/_post'
      expect(response).not_to render_template 'kaminari/_page'
      expect(response).not_to render_template 'kaminari/_next_page'
      expect(response).to render_template 'kaminari/_paginator'
    end
  end
end