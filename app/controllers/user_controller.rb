class UserController < ApplicationController

	skip_before_action :require_login, only: [ :login, :authenticate, :register, :submit_registration ]

	# Displays the sign in form where an user may authenticate him/herself. 
	def login
		redirect_to dashboard_index_path unless current_user.nil?
	end

	# Checks if the given username and password parameters match a corresponing
	# record in the database. If it does then an authentication session is started
	# for the user in which the user can access other services too.
	def authenticate
		credentials = credential_params
		user_candidate = User.where(email: credentials[:email], password: User.hash_password(credentials[:password])).first

		redirect_to user_login_path if user_candidate.nil? 

		session[:user_id] = user_candidate.id

		redirect_to dashboard_index_path
	end

	def forgotten_password
	end

	# Displays the user account registration form. During this step, no new user
	# objects will be created
	def register
	end

	# Attempts to register a new user account. A new User object will be save in the
	# database if the process was successful.
	def submit_registration
		user = User.new(registration_params)
		user.password = User.hash_password user.password
		user.password_confirmation = User.hash_password user.password_confirmation

		if user.valid?
			flash[:info] = "Registration was successful. Now, please, sign in using your new user account"
			user.save!
			redirect_to user_login_path
		else
			flash[:error] = user.errors.full_messages.join "\n"
			redirect_to user_register_path
		end
	end

	def create_user
	end

private

	def credential_params
		params.require(:credentials).permit(:email, :password)
	end

	def registration_params
		params.require(:registration).permit(:email, :email_confirmation, :name, :password, :password_confirmation)
	end
end
