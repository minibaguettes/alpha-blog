class ArticlesController < ApplicationController
  # performs this action/method before doing anything else only for the included methods
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # specify actions that won't need method; all other actions require this
  before_action :require_user, except: [:show, :index] 
  # make sure user is logged in (above line) before checking to see if the user is the article author
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    #@article = Article.find(params[:id])
  end

  def index
    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
    #@article = Article.find(params[:id])
    
  end

  def create
    #@article = Article.new(params.require(:article).permit(:title, :description))
    @article = Article.new(article_params)
    @article.user = current_user
    # require top lvl key or article and permit title and description to be used to create article object
    # render plain: @article.inspect
    # render plain: @article will display the article object
    # .inspect will display the article information; id, title, description
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render 'new', status: :unprocessable_entity
    end
    #redirect_to article_path(@article)
    # extracts id from @article and uses to form path

  end

  def update
    # find article to edit
    #@article = Article.find(params[:id])
    # update with latest title and description (whitelist it, make title and description available to use)
    #if @article.update(params.require(:article).permit(:title, :description))
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      # validation errors, must correct, so return to the edit page  
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    # find article
    #@article = Article.find(params[:id])
    # destroy article
    @article.destroy
    # redirect to list of articles
    redirect_to articles_path
  end

  # not a code block; applies to anything below it, no need for end line
  private 

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own articles"
      redirect_to @article
    end
  end

end