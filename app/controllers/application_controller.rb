class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::MimeResponds
  # http_basic_authenticate_with name: "admin", password: "secret"
  byebug
  before_action :auth

  def auth
    authenticate_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user && user.password == password
        @current_user = user
      else
        request_http_basic_authentication
      # render json: { message: 'Authentication failed'}, status: 401
      end
    end
    
  end
end
