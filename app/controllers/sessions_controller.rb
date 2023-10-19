class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user and user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in Successfully"
      redirect_to user
    else
      flash.now[:alert] = "Incorrect email or Password"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Lgged Out"
    redirect_to root_path
  end

end
