module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = "Log in first"
      redirect_to login_path
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = 'Method Not Allowed'
      redirect_to url_for(:back)
    end

  end
end
