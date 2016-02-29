class EventsController < ApplicationController
	before_action :set_event, only: [:show]

	def new
		@event = Event.new
	end

	def index
		@events = Event.all
	end

	def show
	end

	def create
		@event = User.new(user_params)
		if @event.save
			redirect_to @event, notice: 'Event was successfully created.'
		else
			render action: 'new', notice: 'Event creation was not successfull.'
		end
	end

	private

	def set_event
		@event = Event.find(params[:id])
	end

	def user_params
		params.require(:event).permit(:description, :location, :date)
	end
end
