class ApplicationController < ActionController::Base

  # makes available to views instead of only controllers
  helper_method :current_user, :logged_in?

  # return details of user who is logged in
  # using session hash, have access to curr user id 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # if have curr user alr, when referenced, return curr user variable; else query table and return
    # one line, same as below code
    #if session[:user_id] # already set in session controller
    #  User.find(session[:user.id])
    #end
  end

  # checks if user is logged in 
  def logged_in?
    # turn variable into bool, so return bool
    !!current_user
  end

end
