class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user,  except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_same_user_or_admin, only: [:destroy]

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles.paginate(page: params[:page])

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User #{@user.username} was created successfully"
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User #{@user.username} was updated successfully"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "User #{@user.username} was Deleted successfully"
    redirect_to root_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :profile_pic)
  end

  def require_same_user
    if current_user != @user
      error_403
    end
  end

def require_same_user_or_admin
    if current_user != @user && !current_user.admin?
      error_403
    end
  end
end