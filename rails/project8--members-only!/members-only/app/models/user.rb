class User < ActiveRecord::Base
	has_many :posts
	has_secure_password
	validates :name, presence: true, length: { minimum: 6, maximum: 20 }, uniqueness: true
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
	validates :password_digest, presence: true

	before_create :set_init_remember_token

	def new_token
		token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
	end

	def remember
		token = new_token
		self.update(:remember_token => token)
		return token
	end

	private

  	def set_init_remember_token
	  	self.remember_token = new_token
  	end
end
