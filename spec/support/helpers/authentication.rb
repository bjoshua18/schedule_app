module Helpers
  module Authentication
    def login_as(user)
      if respond_to? :visit
        visit login_url
        fill_in :email, with: user.email
        fill_in :password, with: 'password'
        click_on 'Login'
      else
        post login_url, params: { user: { email: user.email, password: 'password' } }
      end
    end
  
    def logout
      delete logout_url
    end
  end
end