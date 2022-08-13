class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :require_user, only: [:edit, :update]
before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    #@user = User.find(params[:id])
    #@articles = @user.articles
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit 
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated."
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    # since the user name is displayed on the page, will throw an error if the user id is simply deleted
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted."
    redirect_to articles_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account!"
      redirect_to @user
    end
  end

end