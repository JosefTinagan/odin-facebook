class PostsController < ApplicationController
  def index
  	@post = current_user.posts.build if user_signed_in?
  	@like = current_user.likes.build if user_signed_in?
  end

  def create
  	@post = current_user.posts.new(post_params)
  	if @post.save
  		flash[:success] = "Posted"
  		redirect_to posts_path
  	else
  		flash[:danger] = "Post unsuccessful"
      @like = current_user.likes.build if user_signed_in?
  		render 'index'
  	end
  end

  private

  	def post_params
  		params.require(:post).permit(:content,:picture)
  	end
end
