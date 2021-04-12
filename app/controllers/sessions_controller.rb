class SessionsController < ApplicationController
  skip_before_action :authorize
  before_action :redirect_if_current_user_exist, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.present? && user.try(:authenticate, params[:user][:password])
      session[:user_id] = user.id.to_s
      redirect_to root_url
    else
      redirect_to login_url, alert: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: 'Logged out'
  end
end
