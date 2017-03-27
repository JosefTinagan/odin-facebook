class FriendRequestsController < ApplicationController

	def create
		@friend_request = current_user.friend_requests.new(friend_id: params[:friend_id])
		if @friend_request.save
			flash[:success] = "Friend Request Sent"
			redirect_to root_url
		else
			flash[:danger].now = "Friend Request Unsuccessful"
			render 'new'
		end
	end

	def destroy
		@request = FriendRequest.find(params[:id])
		@request.destroy
		flash[:success] = "Canceled Request"
		redirect_to root_url
	end
end
