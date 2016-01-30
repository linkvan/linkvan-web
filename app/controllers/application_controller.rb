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
			session[:intended_url] = request.url
			redirect_to new_session_url, alert: "Please sign in first"
		end
	end

	def current_user
    #if !session[:user_id].blank?
		  @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #end
	end

	def require_admin
  		unless current_user_admin?
    		redirect_to root_url, alert: "Unauthorized access!"
  		end
	end

	def current_user_admin?
  		current_user && current_user.admin?
	end

	def require_correct_user_or_admin
    	unless current_user == User.find(params[:id]) || current_user_admin?
      		redirect_to root_url
    	end
  	end

  	def correct_user_or_admin?
  		if current_user_admin?
  			return true
  		elsif current_user
  			current_user.facilities.each do |f|
  				if f.id == Facility.find(params[:id]).id
  					return true
  				end
  			end
  			return false
  		end
  	end

	helper_method :current_user, :current_user_admin?, :require_correct_user_or_admin, :correct_user_or_admin?
	
end
