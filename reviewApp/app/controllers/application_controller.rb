class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def login_required
		redirect_to root_path, alert: "You must be logged in to access this page." if current_user.blank?
	end




	private
	def current_user
		@current_user ||=User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end
