class FlightsController < ApplicationController
	def index
		unless params[:q] == nil
			@flights = Flight.all
		end
	end
end
