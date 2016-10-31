class UsersController < ApplicationController
  before_action :load_user, only: [ :show, :update ]

  def show
    respond_with @user
  end

  def update
    @user.update user_params
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :avatar)
  end

  def load_user
    @user = User.find params[:id]
  end
end