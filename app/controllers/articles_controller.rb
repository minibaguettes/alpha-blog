class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
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
    @article = Article.find(params[:id])
    # update with latest title and description (whitelist it, make title and description available to use)
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      # validation errors, must correct, so return to the edit page  
      render 'edit'
    end
  end

  def destroy
    # find article
    @article = Article.find(params[:id])
    # destroy article
    @article.destroy
    # redirect to list of articles
    redirect_to articles_path
  end
end