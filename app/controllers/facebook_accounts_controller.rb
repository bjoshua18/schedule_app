class FacebookAccountsController < ApplicationController
  before_action :set_facebook_account, only: [:show, :destroy]

  def index
    @facebook_accounts = Current.user.facebook_accounts
  end

  def refresh_pages
    @facebook_accounts = Current.user.facebook_accounts
    if @facebook_accounts
      @facebook_accounts.each(&:set_pages)
      notice = 'Successfully updated Facebook Pages'
    end
    redirect_to facebook_accounts_url, notice: notice || 'Unable to refresh Facebook Pages'
  end

  def destroy
    if (@facebook_account)
      notice = @facebook_account.destroy ? "Successfully disconnected #{@facebook_account.email}" : 'Something was wrong, unable to disconnect facebook account'
    end
    redirect_to facebook_accounts_url, notice: notice || 'Facebook account not found'
  end

  private
    def set_facebook_account
      @facebook_account = Current.user.facebook_accounts.find_by(id: params[:id])
    end
end
