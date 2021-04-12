class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_current_user_exist, only: [:new, :create]

  def index
    @users = User.order(created_at: 1)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: "User #{@user.username} was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
  end

  def destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
