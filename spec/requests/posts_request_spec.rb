require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET #index without logged in" do
    it "redirect to login form" do
      get posts_url

      expect(response).to have_http_status(:redirect)
    end
  end

  context 'As user logged in' do
    let(:user) { create :user }
    let(:facebook_account) { create :facebook_account, user: user }
    let(:twitter_account) { create :twitter_account, user: user }
    let(:facebook_page) { create :facebook_page, facebook_account: facebook_account }
    let(:post1) { create :post, { user: user, publisher: twitter_account } }
    let(:post2) { create :post, { user: user, publisher: facebook_page } }

    before(:each) { login_as user }

    describe 'GET #index' do
      it 'render posts' do
        get posts_url

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #new' do
      it 'render new post form' do
        get new_post_url
        
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create for Twitter' do
      let(:params) do
        {
          post: {
            publisher_id: twitter_account.id.to_s,
            body: 'body test',
            publish_at: (DateTime.current + 7.days).to_s
          }
        }  
      end

      it 'creates a new post and redirect to posts index' do
        post posts_url, params: params

        expect(response).to redirect_to(:posts)
        follow_redirect!

        expect(response.body).to include('Post was scheduled successfully')
      end
    end

    describe 'POST #create for Facebook' do
      let(:params) do
        {
          post: {
            publisher_id: facebook_page.id.to_s,
            body: 'body test',
            publish_at: (DateTime.current + 7.days).to_s
          }
        }  
      end

      it 'creates a new post and redirect to posts index' do
        post posts_url, params: params

        expect(response).to redirect_to(:posts)
        follow_redirect!

        expect(response.body).to include('Post was scheduled successfully')
      end
    end

    describe 'POST #create with invalid params' do
      let(:fake_params) do
        {
          post: {
            publisher_id: '9873645',
            body: 'body test',
            publish_at: (DateTime.current + 7.days).to_s
          }
        }  
      end

      it 'redirect to new post form' do
        post posts_url, params: fake_params
  
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      it 'render edit post form' do
        get edit_post_url post1

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    describe 'PUT #update a Twitter post' do
      let(:params) do
        {
          post: {
            publisher_id: twitter_account.id.to_s,
            body: 'body test updated',
            publish_at: (DateTime.current + 7.days).to_s
          }
        }  
      end

      it 'update post and redirect to posts index' do
        put "#{posts_url}/#{post1.id}", params: params

        expect(response).to redirect_to(:posts)
        follow_redirect!

        expect(response.body).to include('Post was updated successfully')
      end
    end

    describe 'PUT #update a Facebook post' do
      let(:params) do
        {
          post: {
            publisher_id: facebook_page.id.to_s,
            body: 'body test updated',
            publish_at: (DateTime.current + 7.days).to_s
          }
        }  
      end

      it 'update post and redirect to posts index' do
        put "#{posts_url}/#{post2.id}", params: params

        expect(response).to redirect_to(:posts)
        follow_redirect!

        expect(response.body).to include('Post was updated successfully')
      end
    end

    describe 'PUT #update with invalid params' do
      let(:fake_params) do
        {
          post: {
            publisher_id: twitter_account.id.to_s,
            body: '',
            publish_at: (DateTime.current + 7.days).to_s
          }
        }  
      end

      it 'render edit post form' do
        put "#{posts_url}/#{post1.id}", params: fake_params

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    describe 'DELETE #destroy' do
      it 'destroy post and redirect to posts index' do
        delete "#{posts_url}/#{post1.id}"

        expect(response).to redirect_to(:posts)
        follow_redirect!

        expect(response.body).to include('Post was unscheduled')
      end
    end

    describe 'DELETE #destroy a missed post' do
      it 'redirect to posts index with error message' do
        delete "#{posts_url}/#{post1.id}"
        delete "#{posts_url}/#{post1.id}"

        expect(response).to redirect_to(:posts)
        follow_redirect!

        expect(response.body).to include('Post not found')
      end
    end
  end
end
