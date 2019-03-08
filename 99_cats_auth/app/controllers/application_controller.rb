class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in? 
  
  def my_authentication
     if logged_in? 
        redirect_to cats_url
     end
  end

	def current_user
		return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
	
	def login!(user)
		@current_user = user
    session[:session_token] = user.reset_session_token!
	end

	def logout!
		current_user.try.(:reset_session_token!)
		session[:session_token] = nil
	end

	def logged_in?
		!!current_user
	end



end
