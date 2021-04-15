require 'rails_helper'

RSpec.describe FacebookPage, type: :model do
  describe 'Document schema' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }

    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:token).of_type(String) }
    it { is_expected.to have_field(:page_id).of_type(String) }
    it { is_expected.to have_field(:category).of_type(String) }

    it { is_expected.to have_many(:posts) }
    it { is_expected.to belong_to(:facebook_account) }
  end

  describe '#save' do
    context 'with params from FactoryBot' do
      let(:facebook_account) { create :facebook_account }

      subject(:facebook_page) { build :facebook_page, facebook_account: facebook_account }

      it { is_expected.to be_valid }

      context 'after_save' do
        before(:each) { facebook_page.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'with no Facebook account referenced' do
      subject(:facebook_page) do
        described_class.new(
          name: nil
        )
      end
  
      it { is_expected.not_to be_valid }
    end
  end
end
