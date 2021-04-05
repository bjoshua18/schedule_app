require 'rails_helper'

RSpec.describe "home/index.html.haml", type: :view do
  context 'to guests' do
    it 'render guest partial' do
      render
      expect(response).to render_template 'home/_guest'
    end
  end

  context 'to users' do
    let(:user_without_acc) { create :user }
    let(:user_with_acc) { create :user_with_many_accounts, tw_counter: 2, fb_counter: 2 }
    let(:posts) { create_list :post, 5, user: user_with_acc }

    describe 'without accounts' do
      before(:each) do
        Current.user = user_without_acc
        render
      end

      it 'render dashboard' do
        expect(response).to render_template 'home/_dashboard'
        expect(response).to render_template 'shared/_new_account_btns'
        expect(response).to render_template 'home/_counters'
        expect(response.body).to include "Welcome back, <b>#{user_without_acc.username}</b>!"
      end

      it 'not render new_post_button' do
        expect(response).not_to include 'btn btn-success mx-2 text-white new_post_btn'
      end

      it 'not render posts summary' do
        expect(response).not_to include 'row my-5 posts-summary'
      end
    end

    describe 'with accounts and posts' do
      before(:each) do
        Current.user = user_with_acc
        posts.each { |p| p.save }
        render
      end

      it 'render dashboard' do
        expect(response).to render_template 'home/_dashboard'
        expect(response).to render_template 'shared/_new_account_btns'
        expect(response).to render_template 'home/_counters'
        expect(response.body).to include "Welcome back, <b>#{user_with_acc.username}</b>!"
      end

      it 'render new_post_button' do
        expect(response).to include 'btn btn-success mx-2 text-white new_post_btn'
      end

      it 'render posts summary' do
        expect(response).to include 'row my-5 posts-summary'
      end
    end
  end
end
