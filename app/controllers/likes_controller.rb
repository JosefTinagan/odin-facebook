class LikesController < ApplicationController

	def create
		@like = current_user.likes.new(like_params)
		if @like.save
			flash[:success] = "Like successful"
			redirect_to posts_path
		else
			flash[:danger] = "Like unsuccessful"
			render 'index'
		end
	end

	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		flash[:success] = "Unliked"
		redirect_to posts_path
	end	

	private

		def like_params
			params.permit(:post_id)
		end
end
