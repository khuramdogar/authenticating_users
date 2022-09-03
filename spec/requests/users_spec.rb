require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    before(:each) do
      @attr = { :first_name => "Example User",
                :last_name => "Example User3",
                :email => "user@example.com",
                :password => "secret",
                :password_confirmation => "secret"
      }
		end
		
  
  end
end
