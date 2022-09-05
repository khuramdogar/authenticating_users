require 'rails_helper'

RSpec.describe "Users", type: :request do
	before(:each) do
		@user1 = {email: "jane@doe.com", password: "pw1234", password_confirmation: 'pw1234', first_name: "Anything", last_name: "Lorem ipsum"}
		@user2 = { user: {email: "john@doe.com", password: "password", password_confirmation: 'password', first_name: "John", last_name: "Doe"}}
		User.create(@user1)
	end
	
	context 'POST Create' do
		it "SignUp Works" do
			post users_path, params: @user2
			expect(response).to redirect_to(root_path)
			expect(flash[:success]).to eq("Signup Successful")
			post login_path, params: { user: {email: @user2[:user][:email], password: @user2[:user][:password]}}
			expect(response).to redirect_to(profile_path)
			expect(flash[:success]).to eq("You have successfully Logged In")
		end
	end
	
	context 'GET New' do
		it "is expected to have status 200" do
			get signup_path
			expect(response.status).to eq(200)
			expect(response.body).to include("Already have an account?")
		end
	end
	
	context 'GET Index' do
		it "is expected to have status 200" do
			get root_path
			expect(response.status).to eq(200)
		end
	end
	
end
