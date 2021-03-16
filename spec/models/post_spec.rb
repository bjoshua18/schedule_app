require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Document schema' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }

    it { is_expected.to have_field(:body).of_type(String) }
    it { is_expected.to have_field(:publish_at).of_type(Time) }
    it { is_expected.to have_field(:tweet_id).of_type(String) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:twitter_account) }

    it { is_expected.to validate_length_of(:body) }
    it { is_expected.to validate_presence_of(:publish_at) }
  end
end
