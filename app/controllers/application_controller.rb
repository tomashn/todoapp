class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper_method :current_user_session, :current_user

	protected
	
		def current_user_session
			@current_user_session ||= UserSession.find
		end

		def current_user
			@current_user ||= current_user_session && current_user_session.user
		end

		def authenticate
			unless current_user
				flash[:notice] = "You are not logged in. Log in first to access the page."
				redirect_to login_path
				return false
			end
		end
end
