class Post < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	
	validates :author_id, presence: true
	validates :content, presence: true

	has_many :likes
	has_many :likers, through: :likes, source: :user

	
	
end
