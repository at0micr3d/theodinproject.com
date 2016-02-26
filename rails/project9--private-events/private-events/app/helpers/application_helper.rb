module ApplicationHelper
	def current_user
		user_name = cookies[:name]
		if user_name
			user_name
		else
			nil
		end
	end
end
