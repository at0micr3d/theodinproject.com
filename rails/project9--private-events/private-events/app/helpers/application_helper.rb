module ApplicationHelper
	def current_user
		cookies[:name]
	end
end
