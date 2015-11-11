class User < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
	validates :email, presence: true
	validates :adress, presence: true
	validates :phone_no, numericality: true

	has_many :posts
	has_many :comments
end
