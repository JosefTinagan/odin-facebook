class UsersController < ApplicationController

	before_action :authenticate_user!, only: [:index]
	before_action :correct_user, only: [:edit,:update]
	def index
		@users = User.all
		@friend_requests = FriendRequest.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated!"
			redirect_to @user
		else
			flash[:danger] = "Profile not updated"
			render 'edit'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :avatar)
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless @user == current_user
		end
end
