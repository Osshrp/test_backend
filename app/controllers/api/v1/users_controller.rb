class Api::V1::UsersController < ApplicationController

  def create
    byebug
    user = User.new user_params
    if user.save
      render json: user.token, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname)
  end
end
