# README
This is the [final rails assignment](http://www.theodinproject.com/ruby-on-rails/final-project) of theodinproject.com

## Requirements

* [DONE] Use Postgresql for your database from the beginning (not sqlite3), that way your deployment to Heroku will go much more smoothly. See the Heroku Docs for setup info.
* [DONE] Users must sign in to see anything except the sign in page.
* [DONE] User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
* [DONE] Users can send Friend Requests to other Users.
* [DONE] A User must accept the Friend Request to become friends.
* The Friend Request shows up in the notifications section of a User's navbar.
* Users can create Posts (text only to start).
* Users can Like Posts.
* Users can Comment on Posts.
* Posts should always display with the post content, author, comments and likes.
* Treat the Posts Index page like the real Facebook's "Timeline" feature -- show all the recent posts from the current user and users she is friends with.
* Users can create a Profile with a Photo (just start by using the Gravatar image like you did in the Rails Tutorial).
* The User Show page contains their Profile information, photo, and Posts.
* The Users Index page lists all users and buttons for sending Friend Requests to those who are not already friends or who don't already have a pending request.
* Sign in should use Omniauth to allow a user to sign in with their real Facebook account. See the RailsCast on FB authentication with Devise for a step-by-step look at how it works.
* Set up a mailer to send a welcome email when a new user signs up. Use the letter_opener gem (see docs here) to test it in development mode.
* Deploy your App to Heroku.
* Set up the SendGrid add-on and start sending real emails. It's free for low usage tiers.

## Models
The following models were used: (non were damaged during the making of this app)

```ruby
User:
	has_many :requesting_friendships, class_name: "Friendship", foreign_key: :requestee_id, dependent: :destroy
	has_many :requested_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
	has_many :requesting_friends, through: :requesting_friendships, source: :requester
	has_many :requested_friends, through: :requested_friendships, source: :requestee

	has_many :authored_posts, class_name: "Post", foreign_key: :author
	has_many :user_posts
	has_many :liked_posts, through: :user_posts, source: :post

```

```ruby
Friendship:
	belongs_to :requester, class_name: "User"
	belongs_to :requestee, class_name: "User"
	requester_id
	requestee_id
```

```ruby
User_post:
	belongs_to :user, dependent: :destroy
	belongs_to :post, dependent: :destroy
	user_id
	post_id
```

```ruby
Post:
	belongs_to :author, class_name: "User"
	author_id

	has_many :user_posts
	has_many :likers, through: :user_posts, source: :user

	has_many :comments
```

```ruby
Comment:
	belongs_to :post
	post_id
```