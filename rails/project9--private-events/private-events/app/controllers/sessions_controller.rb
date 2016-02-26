class SessionsController < ApplicationController

	def new
	end

	def create 
		login_name = params[:name]
		cookies[:name] = login_name
		flash[:succes] = "you logged in as " + login_name
		redirect_to root_url
	end
end
