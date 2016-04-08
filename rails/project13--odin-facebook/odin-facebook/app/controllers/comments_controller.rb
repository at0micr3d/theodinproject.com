class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			redirect_to :back
		else
			flash[:error] = "failed to comment."
			redirect_to :back
		end
	end

	private

	  def comment_params
	  	params.fetch(:comment, {}).permit(:author_id, :post_id, :content)
	  end
end

