require 'rails_helper'

RSpec.describe "FacebookAccounts", type: :request do
  describe "GET #index without logged in" do
    it "redirect to login form" do
      get facebook_accounts_url

      expect(response).to have_http_status(:redirect)
    end
  end

  context 'As user logged in' do
    let(:user) { create :user }
    let(:account) { create :facebook_account, user: user }

    before(:each) { login_as user }

    describe 'GET #index' do
      it 'render facebook accounts' do
        get facebook_accounts_url

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    describe 'DELETE #destroy' do
      it 'destroy facebook account and redirect to facebook accounts index' do
        delete "#{facebook_accounts_url}/#{account.id}"

        expect(response).to redirect_to(:facebook_accounts)
        follow_redirect!

        expect(response.body).to include("Successfully disconnected #{account.email}")
      end
    end

    describe 'DELETE #destroy a missed facebook_account' do
      it 'redirect to facebook accounts index with error message' do
        delete "#{facebook_accounts_url}/#{account.id}"
        delete "#{facebook_accounts_url}/#{account.id}"

        expect(response).to redirect_to(:facebook_accounts)
        follow_redirect!

        expect(response.body).to include('Facebook account not found')
      end
    end
  end
end
