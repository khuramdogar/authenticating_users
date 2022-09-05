class UsersController < ApplicationController
  before_action :authorize, only: [:profile]

  def index
  end
  
  def profile
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_path, success: "Signup Successful"
    else
      redirect_to signup_path, error: user.errors.messages
    end
  end
  
end
