require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  context '' do
    let(:user) { create :user_with_many_accounts, tw_counter: 1, fb_counter: 0 }
    let(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/posts/page_flow.png'), 'image/png') }
    let!(:scheduled_posts) { create_list :post, 2, user: user, image: image }
    let!(:published_posts) { create_list :published_post, 5, user: user, image: image }
    before(:each) { Current.user = user }

    describe '#scheduled_posts' do
      it 'return posts that not published yet' do
        expect(helper.scheduled_posts.count).to eq(2)
      end
    end
    
    describe '#published_posts' do
      it 'return published posts' do
        expect(helper.published_posts.count).to eq(5)
      end
    end
  end
end
