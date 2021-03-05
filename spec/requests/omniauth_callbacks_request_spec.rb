require 'rails_helper'

RSpec.describe "OmniauthCallbacks", type: :request do

  describe "GET /twitter" do
    it "returns http success" do
      get "/omniauth_callbacks/twitter"
      expect(response).to have_http_status(:success)
    end
  end

end
