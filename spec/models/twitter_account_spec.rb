require 'rails_helper'

RSpec.describe TwitterAccount, type: :model do
  describe 'Document schema' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }

    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:username).of_type(String) }
    it { is_expected.to have_field(:image).of_type(String) }
    it { is_expected.to have_field(:token).of_type(String) }
    it { is_expected.to have_field(:secret).of_type(String) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:posts) }

    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe '#save' do
    context 'with params from FactoryBot' do
      subject(:twitter_account) { build(:twitter_account) }

      it { is_expected.to be_valid }

      context 'after_save' do
        before(:each) { twitter_account.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'with wrong params from scratch' do
      subject(:post) do
        described_class.new(
          username: ''
        )
      end
  
      it { is_expected.not_to be_valid }
    end
  end
end
