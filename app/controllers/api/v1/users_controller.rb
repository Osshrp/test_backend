class Api::V1::UsersController < ApplicationController
  respond_to :html, :json

  before_action :load_user, only: [ :show, :update ]

  def show
    respond_with :api, :v1, @user
  end

  def update
    @user.update user_params
    respond_with :api, :v1, @user
    end
  end

  def create
    @user = User.new user_params
    respond_with :api, :v1, @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :avatar)
  end

  def load_user
    @user = User.find params[:id]
  end
end
