class SessionController < ApplicationController
	def new
	end

	def create
		cookies[:name] = params[:name]
		redirect_to root_path
	end
end
