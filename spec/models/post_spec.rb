require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Document schema' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }

    it { is_expected.to have_field(:body).of_type(String) }
    it { is_expected.to have_field(:publish_at).of_type(Time) }
    it { is_expected.to have_field(:post_id).of_type(String) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:publisher) }

    it { is_expected.to validate_length_of(:body) }
    it { is_expected.to validate_presence_of(:publish_at) }
  end

  describe '#save' do
    context 'Twitter post with params from scratch' do
      let(:user) { create :user }
      let(:twitter_account) { create :twitter_account }

      subject(:post) do
        described_class.new(
          user: user,
          publisher: twitter_account,
          body: 'Test body',
          publish_at: DateTime.current + 7.days,
          post_id: nil,
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/posts/page_flow.png'), 'image/png')
        )
      end

      it { is_expected.to be_valid }

      context 'after_save' do
        before(:each) { post.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'Facebook post with params from scratch' do
      let(:user) { create :user }
      let(:facebook_page) { create :facebook_page }

      subject(:post) do
        described_class.new(
          user: user,
          publisher: facebook_page,
          body: 'Test body',
          publish_at: DateTime.current + 7.days,
          post_id: nil,
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/posts/page_flow.png'), 'image/png')
        )
      end

      it { is_expected.to be_valid }

      context 'after_save' do
        before(:each) { post.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'with wrong params from scratch' do
      subject(:post) do
        described_class.new(
          body: '',
          publish_at: '',
        )
      end
  
      it { is_expected.not_to be_valid }
    end
  end
end
