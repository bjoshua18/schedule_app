require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Document schema' do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to have_timestamps }

    it { is_expected.to have_field(:username).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String) }
    it { is_expected.to have_field(:password_digest).of_type(String) }

    it { is_expected.to have_many(:twitter_accounts) }
    it { is_expected.to have_many(:facebook_accounts) }
    it { is_expected.to have_many(:posts) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_format_of(:email).with_format(/\A[^@\s]+@[^@\s]+\z/) }
  end

  describe '#save' do
    context 'with params from scratch' do
      subject(:user) do
        described_class.new(
          username: 'usuario_test',
          email: 'usuario_test@example.com',
          password: 'password'
        )
      end

      it { is_expected.to be_valid }
      
      context 'after_save' do
        before(:each) { user.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'with params from FactoryBot' do
      subject(:user) { build(:user) }      

      it { is_expected.to be_valid }
      
      context 'after_save' do
        before(:each) { user.save }

        it { is_expected.to be_persisted }
      end
    end

    context 'with wrong params from scratch' do
      subject(:user) do
        described_class.new(
          username: '',
          email: '',
          password: '',
        )
      end

      it { is_expected.not_to be_valid }
    end
  end

  context '#total_accounts' do
    describe 'user with accounts' do
      subject(:user) { create :user_with_many_accounts, tw_counter: 3, fb_counter: 3 }
  
      it 'return the sum of all accounts' do
        expect(subject.total_accounts).to eq(6)
      end
    end
  
    describe 'user without accounts' do
      subject(:user) { create :user }
  
      it 'return 0' do
        expect(subject.total_accounts).to eq(0)
      end
    end
  end

  context '#has_any_account?' do
    describe 'user with accounts' do
      subject(:user) { create :user_with_many_accounts, tw_counter: 1, fb_counter: 1 }

      it 'return true' do
        expect(subject.has_any_account?).to eq true
      end
    end

    describe 'user without accounts' do
      subject(:user) { create :user }
      
      it 'return false' do
        expect(subject.has_any_account?).to eq false
      end
    end
  end
end
