class CommentsController < ApplicationController
	include CommentsHelper

	# def index
	# 	@comment = Comment.all
	# end

	def create
		@comment = Comment.new(comment_params)
		@comment.article_id = params[:article_id]
		@comment.save

		# flash.notice = "Article '#{@article.title}' created!"

		redirect_to article_path(@comment.article)
	end


end
