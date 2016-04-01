class User < ActiveRecord::Base
  before_save :default_values
  def default_values
    self.update_attributes(:admin => false) if self.admin == nil
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :firstname, :lastname, :email, :age, presence: true
  
  has_many :requesting_friendships, class_name: "Friendship", foreign_key: :requestee_id, dependent: :destroy
  has_many :requested_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
	has_many :requesting_friends, through: :requesting_friendships, source: :requester
  has_many :requested_friends, through: :requested_friendships, source: :requestee
  
  def admin?
    self.admin
  end

  def name
  	[firstname, lastname].join(' ')
  end

  def friends_with?(other_user)
    self.friends.any? { |f| f.id == other_user.id }
  end

  # has current user already requested friendship with other user?
  def friend_request_pending?(other_user)
    requested_friendships.to_ary.any? { |u| u.requestee_id == other_user.id }
  end

  # has current user already been requested friendship by other user?
  def friend_invite_pending?(other_user)
    requesting_friendships.to_ary.any? { |u| u.requester_id == other_user.id }
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
    requesting_friendships.where("requester_id = ?", of_user.id).take.accept
  end

  def friends
    requested_friends.where("accepted= ?", true).to_ary + requesting_friends.where("accepted= ?", true).to_ary
  end
end
