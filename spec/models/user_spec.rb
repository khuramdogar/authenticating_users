require 'rails_helper'
require 'factories/users'

RSpec.describe User, type: :model do
	
	let(:user) { create(:user) }
	
	context 'validations' do
		
		it { should validate_presence_of(:first_name) }
		it { should validate_presence_of(:last_name) }
		it { should validate_presence_of(:email) }
		it { should validate_presence_of(:password) }
		it { should validate_length_of(:password) }
		it { should validate_uniqueness_of(:email) }
		it { should_not allow_value("test@test").for(:email) }
	end
	
  context 'Scope Test' do
		it "is valid with valid attributes" do
			expect(user).to be_valid
		end
		
  end
end
