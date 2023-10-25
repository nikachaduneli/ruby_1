class CategoriesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_admin, only: [:destroy, :edit, :update]


  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def show
    @articles = @category.articles.paginate(page: params[:page])
  end

  def create

    @category = Category.new(category_params)
    if @category.valid?
      @category.save
      flash[:notice] = "Category created successfully"
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was updated successfully'
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
    flash[:notice] = "Category has been deleted"
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_article
    @category = Category.find(params[:id])
  end

end
