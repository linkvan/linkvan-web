class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :allow_iframe_requests

private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

	def require_signin
		unless current_user
			redirect_to new_session_url, alert: "Please sign in first"
		end
	end

	def current_user
		User.find(session[:user_id]) if session[:user_id]
	end

	helper_method :current_user
end
