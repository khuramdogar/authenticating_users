module FlashHelper
	def classes_for_flash(flash_type)
		case flash_type
		when "success"
			"bg-green-100 text-green-700"
		when "error"
			"bg-red-100 text-red-700"
		when "notice"
			"bg-yellow-100 text-yellow-700"
		else
			"bg-blue-100 text-blue-700"
		end
	end
end
