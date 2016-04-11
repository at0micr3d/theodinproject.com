class User < ActiveRecord::Base
  before_save :default_values
  def default_values
    self.update_attributes(:admin => false) if self.admin == nil
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :firstname, :lastname, :email, :age, presence: true

  # omniauthable with facebook
  devise :omniauthable, :omniauth_providers => [:facebook]
  # Friendships with other users
  has_many :requesting_friendships, class_name: "Friendship", foreign_key: :requestee_id, dependent: :destroy
  has_many :requested_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
  has_many :requesting_friends, through: :requesting_friendships, source: :requester
  has_many :requested_friends, through: :requested_friendships, source: :requestee
  include UserMethods::Relationships

  # Likes and author of posts
  has_many :authored_posts, class_name: "Post", foreign_key: :author_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  #comments on posts
  has_many :comments, foreign_key: :author_id
  

  def has_liked?(post)
    liked_posts.any? { |p| p.id == post.id }
  end

  def admin?
    self.admin
  end

  def name
  	[firstname, lastname].join(' ')
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.password = Devise.friendly_token[0,20]
    end
  end

end

