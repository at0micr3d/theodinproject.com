class UsersController < ApplicationController
	before_action :set_user, only: [:show]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user, notice: 'User was successfully created.'
		else
			render action: 'new', notice: 'User creation was not successfull.'
		end
	end

	def show
		@created_events_past = @user.owner_events.past
		@created_events_future = @user.owner_events.future
		@invited_events_past = @user.invitee_events.past
		@invited_events_future = @user.invitee_events.future
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
    params.require(:user).permit(:name, :age)
  end
end
