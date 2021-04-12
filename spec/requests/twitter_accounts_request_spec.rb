require 'rails_helper'

RSpec.describe "TwitterAccounts", type: :request do
  describe "GET #index without logged in" do
    it "redirect to login form" do
      get twitter_accounts_url

      expect(response).to have_http_status(:redirect)
    end
  end

  context 'As user logged in' do
    let(:user) { create :user }
    let(:account) { create :twitter_account, user: user }

    before(:each) { login_as user }

    describe 'GET #index' do
      it 'render twitter accounts' do
        get twitter_accounts_url

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    describe 'DELETE #destroy' do
      it 'destroy twitter account and redirect to twitter accounts index' do
        delete "#{twitter_accounts_url}/#{account.id}"

        expect(response).to redirect_to(:twitter_accounts)
        follow_redirect!

        expect(response.body).to include("Successfully disconnected @#{account.username}")
      end
    end

    describe 'DELETE #destroy a missed twitter_account' do
      it 'redirect to twitter accounts index with error message' do
        delete "#{twitter_accounts_url}/#{account.id}"
        delete "#{twitter_accounts_url}/#{account.id}"

        expect(response).to redirect_to(:twitter_accounts)
        follow_redirect!

        expect(response.body).to include('Twitter account not found')
      end
    end
  end
end
