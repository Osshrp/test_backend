class Api::V1::UsersController < ApplicationController
  respond_to :json

  def create
    @user = User.new user_params
    respond_with :api, :v1, @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :avatar)
  end
end
