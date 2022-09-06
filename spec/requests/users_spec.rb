require 'rails_helper'
require 'factories/users'

RSpec.describe "Users", type: :request do
	
	before(:each) do
		factory_user = build(:user)
		@user = {
			email: factory_user.email,
			password: factory_user.password,
			password_confirmation: factory_user.password_confirmation,
			first_name: factory_user.first_name,
			last_name: factory_user.last_name
		}
	end
	
	
	context 'POST Create' do
		it "should create User" do
			post users_path, params: {user: @user}
			expect(response).to redirect_to(root_path)
			expect(flash[:success]).to eq("Signup Successful")
		end
	end
	
	context 'GET New' do
		it "is expected to have status 200" do
			get signup_path
			expect(response.status).to eq(200)
		end
	end

	context 'GET Index' do
		it "is expected to have status 200" do
			get root_path
			expect(response.status).to eq(200)
		end
	end
	
end
