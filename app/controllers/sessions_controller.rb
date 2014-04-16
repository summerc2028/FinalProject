class SessionsController < ApplicationController
  def new
  end

  # Create a session for a user if credential exist if not redirects with a failure message
  def create
    user = User.find_by_username(params[:username].downcase)
    if user && user.authenticate(params[:password])
      sign_in user, params[:remember_me]
      flash[:success] = "Successfully Signed In!"
      redirect_back_or usernames_path(user.username)
    else
      flash.now[:danger] = "Invalid username or password"
      render 'new'
    end
  end

  # Terminates current user session (Sign Out)
  def destroy
    sign_out
    redirect_to root_path
  end
end
