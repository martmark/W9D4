class SessionsController < ApplicationController
	before_action :my_authentication, only: [:create, :new]

  def new 
    render :new
  end

	def create 
		
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:error] = 'Wrong username/password'
      redirect_to new_session_url
    else
      login!(user)
			# flash[:success] = 'Welcome back!'
			redirect_to cats_url
		end

  end

	def destroy 
		
 		logout!
  	redirect_to new_session_url
  end
end
