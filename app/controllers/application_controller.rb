class ApplicationController < ActionController::Base
	add_flash_types :success, :error
	
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
	
	def authorize
		redirect_to '/login' unless current_user
	end
end
