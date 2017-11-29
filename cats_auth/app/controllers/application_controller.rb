class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def current_user
    User.find_by session_token: session[:session_token]
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def ensure_login
    redirect_to cats_url unless current_user
  end

  def ensure_loggedout
    redirect_to cats_url if current_user
  end

  def do_u_own_this_cat
    redirect_to cats_url unless current_user.cats.include?(@cat)
  end

end
