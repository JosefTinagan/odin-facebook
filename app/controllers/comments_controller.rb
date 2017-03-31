class CommentsController < ApplicationController

	def create
		@comment = current_user.comments.new(comment_params)
		if @comment.save
			flash[:success] = "Comment successful"
			redirect_to posts_path
		else
			flash[:danger] = "Comment unsuccessful"
			render 'posts/index'
		end
	end

	private

		def comment_params
			params.permit(:post_id, :content)
		end
end
