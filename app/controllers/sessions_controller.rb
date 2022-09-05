class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to profile_path, success: "You have successfully Logged In"
    else
      redirect_to login_path, error: "Invalid Email or Password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged Out"
  end
  
end
