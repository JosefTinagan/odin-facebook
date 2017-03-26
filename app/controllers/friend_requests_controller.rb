class FriendRequestsController < ApplicationController

	def create
		@friend_request = current_user.friend_requests.new(friend_id: params[:friend_id])
		if @friend_request.save
			flash[:success] = "Friend Request Sent"
			redirect_to 'users/index'
		else
			flash[:danger].now = "Friend Request Unsuccessful"
			render 'new'
		end
	end
end
