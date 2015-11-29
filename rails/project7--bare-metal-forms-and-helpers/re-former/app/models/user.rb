class User < ActiveRecord::Base
	validates :username, presence: true#, length: { maximum: 25 }
	validates :email, presence: true#, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
	validates :password, presence: true#, length: { :within => 6..40 }
end
