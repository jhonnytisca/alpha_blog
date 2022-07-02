class CategoriesController < ApplicationController

  before_action :set_category, only: [:edit, :show, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @category = Category.paginate(page: params[:page], per_page: 15)
  end

  def new
    @category = Category.new
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:notice] = "The category was successfully updated"
      redirect_to categories_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 15)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "The category was succesfully created"
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path, status: :see_other
    end
  end
end