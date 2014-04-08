class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      flash[:success] = "Successfully Signed In!"
      redirect_to user_path(session[:user_id])
    else
      flash.now[:danger] = "Invalid username or password"
      render 'new'
    end
  end

  def destroy
  end
end
