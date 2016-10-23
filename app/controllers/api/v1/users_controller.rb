class Api::V1::UsersController < ApplicationController

  def show
    find_user
  end

  def update
    if find_user.update user_params
      redirect_to api_v1_user_path
    end
  end

  def create
    user = User.new user_params
    if user.save
      render json: user.token, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :avatar)
  end

  def find_user
    @user = User.find params[:id]
  end
end
