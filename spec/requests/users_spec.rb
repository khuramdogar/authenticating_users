require 'rails_helper'

RSpec.describe "Test Users", type: :request do
  describe "SignUp, Login and Logout" do
		
		before(:each) do
			@user1 = {email: "jane@doe.com", password: "pw1234", password_confirmation: 'pw1234', first_name: "Anything", last_name: "Lorem ipsum"}
			@user2 = { user: {email: "john@doe.com", password: "password", password_confirmation: 'password', first_name: "John", last_name: "Doe"}}
			User.create(@user1)
		end
		
		it "SignUp View Rendered" do
			get signup_path
			expect(response.status).to eq(200)
			expect(response.body).to include("Already have an account?")
		end

		it "SignUp Works" do
			post users_path, params: @user2
			expect(response).to redirect_to(root_path)
			expect(flash[:success]).to eq("Signup Successful")
			post login_path, params: { user: {email: @user2[:user][:email], password: @user2[:user][:password]}}
			expect(response).to redirect_to(root_path)
			expect(flash[:success]).to eq("You have successfully Logged In")
		end

		it "Login View Rendered" do
			get login_path
			expect(response.status).to eq(200)
			expect(response.body).to include("Forgot Password?")
		end

		it "Login Works with right credentials" do
			post login_path, params: { user: {email: 'jane@doe.com', password: 'pw1234'}}
			expect(response).to redirect_to(root_path)
			expect(flash[:success]).to eq("You have successfully Logged In")
			expect(session[:user_id]).to_not eq(nil)
		end

		it "Login does not Works with wrong credentials" do
			post login_path, params: { user: {email: 'jane@doe.com', password: 'pw12345'}}
			expect(flash[:error]).to eq("Invalid Email or Password")
			expect(response).to redirect_to(login_path)
		end

		it "Logout works" do
			get logout_path
			expect(response).to redirect_to(login_path)
			expect(flash[:notice]).to eq("Logged Out")
			expect(session[:user_id]).to eq(nil)
		end
  
  end
end
