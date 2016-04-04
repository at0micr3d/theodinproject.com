class LikesController < ApplicationController
	before_filter :redirect_back

	def create
		@user_post = UserPost.new(user_post_params)
		if @user_post.save
			flash[:success] = "Liked!"
			redirect_to session[:my_previous_url]n
		else
			flash[:error] = "Unable to like :("
			redirect_to session[:my_previous_url]
		end
	end

	def destroy

	end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_post_params
      params.fetch(:user_post, {}).permit(:user_id, :post_id)
    end

    def redirect_back
      session[:my_previous_url] = URI(request.referer).path
    end
end
