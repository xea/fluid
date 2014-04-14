class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :require_login

	helper_method :current_user, :authenticated?

private

	# Verifies and redirects to the login page if the current user is
	# not authenticated
	def require_login
		unless authenticated?
			flash[:error] = "Not authenticated"
			redirect_to user_login_path
		end
	end

	# Shortcut for checking if the user is signed in
	def authenticated?
		!current_user.nil?
	end

	# Returns the current signed in user if it exists otherwise returns nil
	def current_user
		begin
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		rescue
			flash[:error] = "The user could not be found"
			@current_user = nil
		end
	end

end
