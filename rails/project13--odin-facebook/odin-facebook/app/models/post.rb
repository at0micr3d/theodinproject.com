class Post < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	
	validates :author_id, presence: true
	validates :content, presence: true

	has_many :likes, dependent: :destroy
	has_many :likers, through: :likes, source: :user

	has_many :comments
	
	def self.feed(user = current_user)
		where(author_id: [user.id] + user.friends.to_a)
	end
	
end
