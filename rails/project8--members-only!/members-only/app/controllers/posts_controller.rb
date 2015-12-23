class PostsController < ApplicationController
	before_action :authorized?, only: [:new, :create]

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post && current_user
  		@post.set_author(current_user.id)
  		if @post.save
  			flash[:succes] = 'Post created!'
  			redirect_to posts_path
  		else
  			flash.now[:error] = 'Post is invalid!'
  			render 'new'
  		end
  	else
  		flash.now[:error] = "You're not logged in!"
  		render 'new'
  	end
  end

  def index
  	@posts = Post.all
  end

  private 
    def post_params
    	params.require(:post).permit(:title, :content)
    end


    def authorized?
    	unless logged_in?
    		flash[:error] = 'You need to be logged in for that..'
    		redirect_to login_path
    	end
    end
end
