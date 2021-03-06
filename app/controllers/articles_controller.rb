class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_article_category, only: [:destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    #binding.break
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 6)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created succesfully."
      redirect_to @article #redirect_to article_path(@article)
    else
      render 'new', status: :unprocessable_entity
    end
    #render plain: @article.inspect #params[:article]
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated succesfully."
      redirect_to @article #redirect_to article_path(@article)
    else
      render 'edit', status: :unprocessable_entity
    end
    #render plain: @article.inspect #params[:article]
  end

  def destroy
    @article.destroy
    @article_category.destroy_all
    flash[:notice] = "Article was deleted succesfully."
    redirect_to articles_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_article_category
    @article_category = ArticleCategory.where(article_id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    unless current_user == @article.user || current_user.admin?
      flash[:alert] = "You can only edit or delete your own articles"
      redirect_to @article, status: :see_other
    end
  end
end
