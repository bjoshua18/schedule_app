require 'rails_helper'

RSpec.describe FacebookAccount, type: :model do
  describe 'Document schema' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }

    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String) }
    it { is_expected.to have_field(:image).of_type(String) }
    it { is_expected.to have_field(:token).of_type(String) }
    it { is_expected.to have_field(:token_expires_at).of_type(Time) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:posts) }

    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
