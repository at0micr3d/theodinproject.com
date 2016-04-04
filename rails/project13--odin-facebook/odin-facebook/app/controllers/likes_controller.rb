class LikesController < ApplicationController
	before_filter :redirect_back

	def create
		@like = Like.new(like_params)
		@like.user_id = params[:user_id]
		@like.post_id = params[:post_id]
		if @like.save
			flash.now[:success] = "Liked!"
			redirect_to session[:my_previous_url]
		else
			flash[:error] = "Unable to like :("
			redirect_to session[:my_previous_url]
		end
	end

	def destroy

	end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.fetch(:like, {}).permit(:user_id, :post_id)
    end

    def redirect_back
      session[:my_previous_url] = URI(request.referer).path
    end
end
