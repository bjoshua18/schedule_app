class FacebookAccountsController < ApplicationController
  before_action :set_facebook_account, only: [:show, :destroy]

  def index
    @facebook_accounts = Current.user.facebook_accounts
  end

  def destroy
    @facebook_account = Current.user.facebook_accounts.find_by(id: params[:id])
    @facebook_account.destroy
    redirect_to facebook_accounts_url, notice: "Successfully disconnected #{@facebook_account.email}"
  end

  private
    def set_facebook_account
      @facebook_account = Current.user.facebook_accounts.find_by(id: params[:id])
    end
end
