require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "Forgot and Reset Passwords" do
		
		before(:each) do
			@user1 = {email: "jane@doe.com", password: "pw1234", password_confirmation: 'pw1234', first_name: "Anything", last_name: "Lorem ipsum"}
			@user2 = { user: {email: "john@doe.com", password: "password", password_confirmation: 'password', first_name: "John", last_name: "Doe"}}
			user = User.create(@user1)
			@token = user.send_password_reset
		end
		
		it "Forgot Password Works" do
			post password_resets_path, params: { user: {email: @user1[:email] }}
			expect(flash[:success]).to eq('Email sent with password reset instructions')
			expect(ActionMailer::Base.deliveries.count).to eq(2)
			expect(ActionMailer::Base.deliveries.first.to.first).to eq(@user1[:email])
			expect(ActionMailer::Base.deliveries.first.subject).to eq('Reset password instructions')
			expect(ActionMailer::Base.deliveries.first.body).to include('To reset your password, click the URL below:')
			expect(response).to redirect_to(login_path)
		end

		it "Reset Password View works with valid reset_password_token" do
			get edit_password_reset_path(@token)
			expect(response.status).to eq(200)
			expect(response.body).to include('Reset Password')
		end

		it "Reset Password View does not works with Invalid reset_password_token" do
			get edit_password_reset_path("helloworld123466")
			expect(response.status).to_not eq(200)
			expect(response.body).to_not include('Reset Password')
		end

		it "Update Password Works on valid token and password" do
			put password_reset_path(@token), params: {user: {password: 'password', password_confirmation: 'password' }}
			expect(flash[:success]).to eq('Password has been reset!')
			expect(response).to redirect_to(login_path)
		end

		it "Update Password does not Works on mismatch passwords" do
			put password_reset_path(@token), params: {user: {password: 'password', password_confirmation: '123123' }}
			expect(response).to redirect_to(edit_password_reset_path)
		end

		it "Update Password does not Works on short passwords" do
			put password_reset_path(@token), params: {user: {password: '123', password_confirmation: '123' }}
			expect(response).to redirect_to(edit_password_reset_path)
		end
  
  end
end
