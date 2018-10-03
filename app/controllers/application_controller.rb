class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_user
    if current_user
      unless current_user.currently_logged_in
        current_user.currently_logged_in = true
        current_user.save
      end
    else
      redirect_back(fallback_location: root_path, flash: {danger: "You need to be logged in to do that"})
    end
  end

  def current_user
    @current_user ||= User.find_by(email: session[:email])
  end

  protected
  # 
  # def login_to_jira(user)
  #   login_args = {
  #     'username': Rails.application.secrets.jira_username,
  #     'password': Rails.application.secrets.jira_password
  #   }
  #   headers = {
  #      'Accept': 'application/json',
  #      'Content-Type': 'application/json'
  #   }
  #   response = HTTParty.post('https://doxly-jira.atlassian.net/rest/auth/1/session', body: login_args.to_json, headers: headers)
  #   session[:cookie_name] = response.parsed_response["session"]["name"]
  #   session[:cookie_value] = response.parsed_response["session"]["value"]
  # end
end
