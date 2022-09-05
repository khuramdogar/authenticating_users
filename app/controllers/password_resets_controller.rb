class PasswordResetsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user
      user.send_password_reset
      redirect_to login_path, success: 'E-mail sent with password reset instructions'
    else
      redirect_to new_password_reset_path, error: 'Email is Invalid'
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    if !@user
      redirect_to new_password_reset_path, error: 'Reset Password token is Invalid'
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.password_reset_sent_at < 2.hour.ago
      redirect_to new_password_reset_path, notice: 'Password reset link has expired'
    elsif @user.update(user_params)
      redirect_to login_path, success: 'Password has been reset!'
    else
      redirect_to edit_password_reset_path, error: @user.errors.messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
