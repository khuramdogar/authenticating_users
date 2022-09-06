FactoryBot.define do
	
	factory :user do
		first_name { "Joe" }
		last_name { "Jane" }
		email { "joe@gmail.com" }
		password { "blah123" }
		password_confirmation { "blah123" }
	end
end
