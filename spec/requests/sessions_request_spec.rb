require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  context 'As user not logged in' do
    describe 'GET /login' do
      it 'returns login form' do
        get login_url
  
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end

    describe 'POST /new with fail params' do
      let(:fail_params) do
        {
          user: {
            email: 'test_user@email.com',
            password: 'password'
          }
        }
      end

      it 'render login form with error messages' do
        post login_url, params: fail_params

        expect(response).to redirect_to(:login)
        follow_redirect!

        expect(response.body).to include('Invalid user/password combination')
      end
    end

    describe 'POST /new with correct params' do
      let(:user) { create :user }
      let(:params) do
        {
          user: {
            email: user.email,
            password: 'password'
          }
        }
      end

      it 'login user and redirect to home' do
        post login_url, params: params

        expect(response).to redirect_to(:root)
        follow_redirect!

        expect(response.body).to include("Welcome back, <b>#{user.username}</b>")
      end
    end
  end

  context 'As user logged in' do
    let(:user) { create :user }
    before(:each) { login_as user }

    describe 'GET /login' do
      it 'redirect to home' do
        get login_url

        expect(response).to redirect_to(:root)
      end
    end
  end
end
