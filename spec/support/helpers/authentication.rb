module Helpers
  module Authentication
    def login_as(user)
      if respond_to? :visit
        visit login_path
        fill_in :user_email, with: user.email
        fill_in :user_password, with: user.password
        click_on :login_btn
      else
        post login_url, params: { user: { email: user.email, password: user.password } }
      end
    end
  
    def logout
      delete logout_url
    end
  end
end