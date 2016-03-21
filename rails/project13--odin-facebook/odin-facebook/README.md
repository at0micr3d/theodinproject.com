# README
This is the (final assignment of theodinproject.com)[http://www.theodinproject.com/ruby-on-rails/final-project]

## Models
The following models were used:

User:
	has_many :requesting_friendships, class_name: :friendship, foreign_key: :requestee, dependent: :destroy
	has_many :requested_friendships, class_name: :friendship, foreign_key: :requester, dependent: :destroy
  has_many :requesting_friends, through: :requesting_friendships, source: :requester
  has_many :requested_friends, through: :requested_friendships, source: :requestee

  has_many :authored_posts, class_name: :post, foreign_key: :author
  has_many :user_posts
  has_many :liked_posts, through: :user_posts, source: :post

Friendship:
	belongs_to :requester, class_name: :user
	belongs_to :requestee, class_name: :user
	requester_id
	requestee_id

User_post:
	belongs_to :user, dependent: :destroy
	belongs_to :post, dependent: :destroy
  user_id
  post_id

Post:
	belongs_to :author, class_name: :user
	author_id

	has_many :user_posts
	has_many :likers, through: :user_posts, source: :user

	has_many :comments

Comment:
	belongs_to :post
	post_id