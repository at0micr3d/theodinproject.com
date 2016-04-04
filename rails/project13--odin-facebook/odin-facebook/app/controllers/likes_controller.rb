class LikesController < ApplicationController
	before_filter :redirect_back

	def create
		@like = Like.new(like_params)
		# for some reason the user_id and post_id parameters arent saved.
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
		@like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
		if @like.destroy
			flash.now[:success] = "Unliked!"
			redirect_to session[:my_previous_url]
		else
			flash[:error] = "Unable to unlike :("
			redirect_to session[:my_previous_url]
		end
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
