class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, :email, :age, presence: true
  
  has_many :friendships, class_name: :friendship, foreign_key: :requestee_id, dependent: :destroy
  #has_many :requested_friendships, class_name: :friendship, foreign_key: :requester_id, dependent: :destroy
	#has_many :requesting_friends, through: :requesting_friendships, source: :requester
  #has_many :requested_friends, through: :requested_friendships, source: :requestee
  

  def name
  	[firstname, lastname].join(' ')
  end
end
