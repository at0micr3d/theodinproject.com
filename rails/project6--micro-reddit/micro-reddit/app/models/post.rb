class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :body, presence: true, length: { in: 5..250 }

	belongs_to :user
	has_many :comments
end
