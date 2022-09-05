class ApplicationController < ActionController::Base
	add_flash_types :success, :error
	helper_method :current_user
	
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	
	def authorize
		redirect_to '/login' unless current_user
	end
	
	protected
	
	#we are using user_params in lot of places so we place the method here
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
	
end
