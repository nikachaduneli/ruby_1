class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :destroy, :update]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:destroy, :edit, :update]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page])
  end

  def new
    @article = Article.new
  end


  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.valid?
      @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @article.user = current_user
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully'
      redirect_to @article
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    flash[:notice] = 'Article was Deleted successfully'
    redirect_to articles_path
  end

  def search
    if params[:search].blank?
      redirect_to users_path
    else

    @parameter = params[:search].downcase
    @articles = Article.all.where('lower(title) like :search', search: "%#{@parameter}").paginate(page: params[:page])
    render :index
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
     params.require(:article).permit(:title, :description, category_ids: [], images: [])
  end

  def require_same_user
    if current_user != @article.user
      error_403
    end
  end
end
