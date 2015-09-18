class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "user", password: "password", except: [:index, :show]

  def index
    #for /articles
    @articles = Article.all
  end

  def show
    #for /articles/'id'
    @article = Article.find(params[:id])
  end

  def new
    # @article shouldnt be nil in view (calling @article.errors.any? would throw an error)
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end
 
  def create
    @article = Article.new(article_params)
    # click on save button
    if @article.save
      # go to just created article site /articles/'id' master
      redirect_to @article
    else
      # an error in saving entry occured
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    # click on save button
    if @article.update(article_params)
      # go to just created article site /articles/'id'
      redirect_to @article
    else
      # an error in updating occured
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    # Active Record Object method
    @article.destroy
    # redirect to index page -> no view for deletion necessary
    redirect_to articles_path
  end

  private
  def article_params
    # allow only parameters title and text
    params.require(:article).permit(:title, :text)
  end
end
