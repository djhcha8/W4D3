class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def current_user
    User.find_by session_token: session[:session_token]
  end



end
