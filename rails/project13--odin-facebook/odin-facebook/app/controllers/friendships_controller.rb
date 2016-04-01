class FriendshipsController < ApplicationController
  
  def create
  	requesting_user = User.find_by(id: params[:requester_id])
  	requested_user = User.find_by(id: params[:requestee_id])
  	requesting_user.request_friendship(requested_user)

  	if requesting_user.friend_request_pending?(requested_user)
  		redirect_to users_url, :flash => { :notice => "Request send!" }
 		else
  		redirect_to users_url, :flash => { :notice => "Request could not be send." }
  	end
  end

  def update
    accepting_user = User.find_by(id: params[:requestee_id])
    requesting_user = User.find_by(id: params[:requester_id])
    accepting_user.accept_request(requesting_user)

    if accepting_user.friends_with?(requesting_user)
      redirect_to users_url, :flash => { :notice => "You're now friends!" }
    else
      redirect_to users_url, :flash => { :notice => "Friend acceptation failed!" }
    end
  end

end
