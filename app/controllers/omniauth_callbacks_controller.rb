require 'json'

class OmniauthCallbacksController < ApplicationController
  def twitter
    twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    twitter_account.update({
      name: auth.info.name,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    })

    redirect_to twitter_accounts_url, notice: 'Successfully connected your account'
  end

  def facebook
    puts(auth.to_json)
    facebook_account = Current.user.facebook_accounts.where(email: auth.info.email).first_or_initialize
    facebook_account.update({
      name: auth.info.name,
      email: auth.info.email,
      image: auth.info.image,
      token: auth.credentials.token,
      token_expires_at: auth.credentials.expires_at
    })

    redirect_to facebook_accounts_url, notice: 'Successfully connected your account'
  end

  def auth
    request.env['omniauth.auth']
  end
end
