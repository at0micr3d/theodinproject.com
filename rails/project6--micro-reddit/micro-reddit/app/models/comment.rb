class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post	

	validates :body, presence: true, length: { in: 5..250 }
	validates :user_id, presence: true
	validates :post_id, presence: true	
	validates_associated :user
	validates_associated :post
end
