class User < ActiveRecord::Base
	has_many :posts
	has_secure_password
	validates :name, presence: true, length: { minimum: 6, maximum: 20 }, uniqueness: true
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
	validates :password_digest, presence: true
end
