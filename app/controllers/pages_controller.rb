class PagesController < ApplicationController
  def home
    #redirect_to articles_path if logged_in?
    # use this for top navbar (when clicking on website title in navbar)
    # will redirect to articles listing if logged in
    # will redirect to home page where users can login or sign up 
  end

  def about
  end
end
