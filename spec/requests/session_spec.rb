require 'rails_helper'
require 'factories/users'

RSpec.describe "Sessions", type: :request do
	
	let(:user) { create(:user)}
	
	context "#Login" do
		it "should render Login View" do
			get login_path
			expect(response.status).to eq(200)
		end

		it "should Login with right credentials" do
			post login_path, params: { user: { email: user.email, password: user.password } }
			expect(response).to redirect_to(profile_path)
			expect(flash[:success]).to eq("You have successfully Logged In")
			expect(session[:user_id]).to_not eq(nil)
		end

		it "should not Works with wrong credentials" do
			post login_path, params: { user: {email: user.email, password: 'pw12345'}}
			expect(flash[:error]).to eq("Invalid Email or Password")
			expect(response).to redirect_to(login_path)
		end
	end
	
	context "#Logout" do
		it "should Logout" do
			get logout_path
			expect(response).to redirect_to(login_path)
			expect(flash[:notice]).to eq("Logged Out")
			expect(session[:user_id]).to eq(nil)
		end
  end
end
