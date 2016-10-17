include ActionController::HttpAuthentication::Token::ControllerMethods
class ApplicationController < ActionController::API

  private

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  def self.set_pagination_headers(name, options = {})
    after_action(options) do |controller|
      results = instance_variable_get("@#{name}")
      headers["X-Pagination"] = {
        total_entries: results.total_entries,
        total_pages: results.total_pages,
        current_page: results.current_page,
        first_page: results.current_page == 1,
        last_page: results.next_page.blank?,
        previous_page: results.previous_page,
        next_page: results.next_page,
        offset: results.offset
      }.to_json
    end
  end
end
