class FriendshipsController < ApplicationController

	def create
		@friendship = current_user.friendships.new(friend_id: params[:friend_id])
		if @friendship.save
			friend = User.find(params[:friend_id])
			inverse_friendship(friend)
			remove_request(params[:friend_id])
			flash[:success] = "Friend Added"
			redirect_to root_url
		else
			flash[:danger].now = "Friend not accepted"
			render 'new'
		end
	end

	def destroy
		@friendship = Friendship.find(params[:id])
		remove_inverse_friendship(@friendship.friend_id, @friendship.user_id )
		@friendship.destroy
		flash[:success] = "Removed as Friend"
		redirect_to root_url
	end

	private

		# Create a new friendship in reverse, so the other user can call active_friendship
		def inverse_friendship(user)
			@inverse_friendship = user.friendships.new(friend_id: current_user.id).save
		end

		# When removing a friendship, removes the inverse 
		def remove_inverse_friendship(user,friend)
			@inverse_friendship = Friendship.where(user_id: user, friend_id: friend).first.destroy
		end

		# Removing a friend request
		def remove_request(friend_id)
			@friend_request = FriendRequest.where(user_id: friend_id, friend_id: current_user.id).first.destroy
		end
end
