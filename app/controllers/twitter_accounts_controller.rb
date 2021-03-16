class TwitterAccountsController < ApplicationController
  before_action :set_twitter_account, only: [:show, :destroy]

  def index
    @twitter_accounts = Current.user.twitter_accounts
  end

  def destroy
    notice = 'Twitter account not found'
    if (@twitter_account)
      notice = @twitter_account.destroy ? "Successfully disconnected @#{@twitter_account.username}" : 'Something was wrong, unable to disconnect twitter account'
    end
    redirect_to twitter_accounts_url, notice: notice
  end

  private
    def set_twitter_account
      @twitter_account = Current.user.twitter_accounts.find_by(id: params[:id])
    end
end