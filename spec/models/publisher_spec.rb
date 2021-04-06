require 'rails_helper'

RSpec.describe Publisher, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:token).of_type(String) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:token) }

  it { is_expected.to have_many(:posts) }

  describe '#save' do
    context 'with params from FactoryBot' do
      subject(:publisher) { build :publisher }

      it { is_expected.to be_valid }

      context 'after_save' do
        before(:each) { publisher.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'with wrong params from scratch' do
      subject(:publisher) do
        described_class.new(
          name: nil,
          token: nil
        )
      end
  
      it { is_expected.not_to be_valid }
    end
  end
end
