class Friendship < ActiveRecord::Base
	belongs_to :requester, class_name: "User"
	belongs_to :requestee, class_name: "User"

	validates :requester_id, :uniqueness => {:scope => :requestee_id}

	def accept
		update_attribute(:accepted, true)
	end
end
