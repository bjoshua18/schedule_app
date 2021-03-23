require 'rails_helper'

RSpec.describe "Home", type: :request do

  describe "GET /index without logged in" do
    it "returns http success" do
      get '/'

      expect(response).to have_http_status(:success)
    end

    it 'render index' do
      get '/'

      expect(response).to render_template(:index)
      expect(response.body).not_to include('Welcome back')
    end
  end

  describe 'GET /index as logged user' do
    let(:user) { create :user }
    before(:each) { login_as user }

    it 'render index' do
      get '/'

      expect(response).to render_template(:index)
      expect(response.body).to include("Welcome back, <b>#{user.username}</b>")
    end
  end

end
