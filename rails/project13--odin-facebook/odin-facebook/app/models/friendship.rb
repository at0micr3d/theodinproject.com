class Friendship < ActiveRecord::Base
	belongs_to :requester, class_name: "User"
	belongs_to :requestee, class_name: "User"

	def accept_request
		update_attribute(:accepted, true)
	end
end
