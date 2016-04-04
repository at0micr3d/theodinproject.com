class Post < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	
	validates :author_id, presence: true
	validates :content, presence: true

	has_many :user_posts
	has_many :likers, through: :user_posts, source: :user

	
	
end
