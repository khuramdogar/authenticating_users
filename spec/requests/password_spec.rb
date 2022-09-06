require 'rails_helper'
require 'factories/users'

RSpec.describe "ResetPasswords", type: :request do
	let(:user) { create(:user)}
	
	context "#ForgotPassword" do
		it "should be valid on correct email" do
			post password_resets_path, params: { user: { email: user.email } }
			expect(flash[:success]).to eq('Email sent with password reset instructions')
			expect(response).to redirect_to(login_path)
		end
		
		it "should send email successfully" do
			post password_resets_path, params: { user: { email: user.email } }
			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end
		
		it "should send email to right user" do
			post password_resets_path, params: { user: { email: user.email } }
			expect(ActionMailer::Base.deliveries.first.to.first).to eq(user.email)
		end
		
		it "should not be valid on wrong email" do
			post password_resets_path, params: { user: { email: 'test@test.com' } }
			expect(flash[:error]).to eq('Email is Invalid')
			expect(response).to redirect_to(new_password_reset_path)
		end
	end
	
	context "#ResetPassword" do
		
		let(:token) { user.send_password_reset}

		it "should render Reset Password View with valid reset_password_token" do
			get edit_password_reset_path(token)
			expect(response.status).to eq(200)
		end

		it "should not render Reset Password View with Invalid reset_password_token" do
			get edit_password_reset_path("helloworld123466")
			expect(response.status).to_not eq(200)
		end

		it "should Update Password" do
			put password_reset_path(token), params: {user: {password: 'password', password_confirmation: 'password' }}
			expect(flash[:success]).to eq('Password has been reset!')
			expect(response).to redirect_to(login_path)
		end

  end
end
