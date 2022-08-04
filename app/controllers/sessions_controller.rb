class SessionsController < ApplicationController

  def new
  end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# ruby provides session object, stores info for logged in user
			session[:user_id] = user.id
			flash[:notice] = "Logged in successfully"
			redirect_to user
		else
			# .now => does not persist for one full html request; displays as it happens then disappears
			flash.now[:alert] = "There was something wrong with your login details"
			render 'new', status: :unprocessable_entity
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have been successfully logged out"
		redirect_to root_path
	end

end