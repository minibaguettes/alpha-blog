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

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    # require top lvl key or article and permit title and description to be used to create article object
    # render plain: @article.inspect
    # render plain: @article will display the article object
    # .inspect will display the article information; id, title, description
    if @article.save
      flash[:notice] = "Article was created successfully."  # ruby helper "flash", parameter = name
      redirect_to @article
    else
      render 'new'
    end
    #redirect_to article_path(@article)
    # extracts id from @article and uses to form path

  end

end