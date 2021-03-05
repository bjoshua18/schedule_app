class ApplicationController < ActionController::Base
	before_action :set_current_user
	before_action :authorize

	def set_current_user
		if session[:user_id]
			Current.user = User.find_by(id: session[:user_id])
		end
	end

	protected
		def authorize
			if request.format == Mime[:html]
				unless User.find_by(id: session[:user_id])
					redirect_to login_url, notice: 'Please, log in'
				end
			else
				authenticate_or_request_with_http_basic do |username, password|
					user = User.find_by(name: username)
					user && user.authenticate(password)
				end
			end
		end
end
