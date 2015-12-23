class Post < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true
	validates :content, presence: true, length: { minimum: 15 }

	def set_author(id)
		self.user_id = id
	end
end
