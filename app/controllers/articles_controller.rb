class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def show
    #binding.break
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was created succesfully."
      redirect_to @article #redirect_to article_path(@article)
    else
      render 'new'
    end
    #render plain: @article.inspect #params[:article]
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated succesfully."
      redirect_to @article #redirect_to article_path(@article)
    else
      render 'edit'
    end
    #render plain: @article.inspect #params[:article]
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was deleted succesfully."
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end