class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name],params[:user][:password])
    # debugger
    if user && user.is_password?(params[:user][:password])
      login_user!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = "Wrong credentials!!"
      render :new
    end
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    else
      flash[:errors] = 'No Current User'
    end
      redirect_to new_session_url
  end

end
