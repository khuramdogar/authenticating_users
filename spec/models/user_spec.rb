require 'rails_helper'

RSpec.describe User, type: :model do
	
	let(:user) {
		User.new(email: "jane@doe.com", password: "pw1234", first_name: "Anything", last_name: "Lorem ipsum")
	}
	
	context 'presence validation' do
		it "is not valid without first_name" do
			user.first_name = nil
			expect(user).to_not be_valid
		end
		it "is not valid without last_name" do
			user.last_name = nil
			expect(user).to_not be_valid
		end
		it "is not valid without email" do
			user.email = nil
			expect(user).to_not be_valid
		end
		it "is not valid without password" do
			user.password = nil
			expect(user).to_not be_valid
		end
	end
	
	context 'email validations' do
		it "is not valid without valid email" do
			user.email = 'abc.com'
			expect(user).to_not be_valid
		end
		
		it "is not valid with duplicate email" do
			user1 = User.create(email: "jane@doe.com", password: "pw1234", first_name: "Anything", last_name: "Lorem ipsum",)
			user2 = User.create(email: "jane@doe.com", password: "pw1234", first_name: "Anything", last_name: "Lorem ipsum",)
			expect(user1.valid?).to eq(true)
			expect(user2.valid?).to eq(false)
		end
	end
	
	context 'password validations' do
		it "is not valid with password length less than 6" do
			user.password = "123"
			expect(user).to_not be_valid
		end
		it "is not valid with password length greater than 16" do
			user.password = "123456123456123456"
			expect(user).to_not be_valid
		end
	end
	
  context 'user' do
		it "is valid with valid attributes" do
			expect(user).to be_valid
		end
  end
end
