class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :author, class_name: "User"

	validates :author_id, :content, :post_id, presence: true
end
