require 'rails_helper'

RSpec.describe "Users", type: :request do
  context 'As user not logged in' do
    describe 'GET /users' do
      it 'returns http redirect' do
        get '/users'

        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'POST /users' do
      let(:params) do
        {
          user: {
            username: 'UserTest',
            email: 'usertest@example.com',
            password: 'password',
            password_confirmation: 'password',
          }
        }
      end

      it 'creates a new user and redirect to home page' do
        post '/users', params: params

        expect(response).to redirect_to(:root)
        follow_redirect!

        expect(response.body).to include("User #{params[:user][:username]} was successfully created.")
      end
    end

    describe 'GET /signup' do
      it 'returns http success' do
        get '/signup'

        expect(response).to have_http_status(:success)
      end
    end
  end
end
