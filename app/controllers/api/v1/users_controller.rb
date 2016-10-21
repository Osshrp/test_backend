class Api::V1::UsersController < ActionController::Base
  # layout "application", only: [:show]

  def show
    @user = User.find params["id"]
    # render :layout => "application"
  end

  def update
    byebug
    user = User.find params[:id]
    if user.update user_params
      redirect_to api_v1_user_path
    else
      render '123'
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
end
