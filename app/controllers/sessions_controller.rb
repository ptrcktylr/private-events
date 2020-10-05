class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by('username = ?', params[:username])

    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully!"
      redirect_to root_path
    else
      flash.now.alert = "Invalid username!"
      render "new"
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Logged out successfully!"
    redirect_to root_path
  end

end
