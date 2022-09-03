class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_path, success: "Signup Successful"
    else
      redirect_to signup_path, error: user.errors.messages
    end
  end

  def new
  end

  def index
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  
end
