class EventsController < ApplicationController
	before_action :set_user, only: [:new, :create]
	before_action :set_event, only: [:show]

	def new
		@event = Event.new
	end

	def index
		@events = Event.all
		@events_past = Event.all.past
		@events_future = Event.all.future
	end

	def show
		@invitees = @event.invitees
	end

	def create		
		@event = @user.owner_events.build(event_params)

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
  
  def set_user
		 p @user = User.find_by(name: cookies[:name])
		 if @user == nil
			flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url
		end
	end

	def event_params
		params.require(:event).permit(:description, :location, :date)
	end
end
