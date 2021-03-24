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
end
