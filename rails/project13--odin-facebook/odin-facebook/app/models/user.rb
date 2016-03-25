class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, :email, :age, presence: true
  
  has_many :requesting_friendships, class_name: "Friendship", foreign_key: :requestee_id, dependent: :destroy
  has_many :requested_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
	has_many :requesting_friends, through: :requesting_friendships, source: :requester
  has_many :requested_friends, through: :requested_friendships, source: :requestee
  

  def name
  	[firstname, lastname].join(' ')
  end

  def friends_who_have_accepted
    requested_friends.where("accepted= ?", true)
  end

  def friends_who_are_accepted
    requesting_friends.where("accepted= ?", true)
  end

  def request_friendship(with_user)
    requested_friendships.create(requestee_id: with_user.id)
  end

  def accept_request(of_user)
    requesting_friendships.where("requester_id = ?", of_user.id).take.accept_request
  end

  def friends
    requested_friends.where("accepted= ?", true).to_ary + requesting_friends.where("accepted= ?", true).to_ary
  end
end
