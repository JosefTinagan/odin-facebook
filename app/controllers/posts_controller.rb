class PostsController < ApplicationController
  def index
  	@posts = Post.where(author_id: current_user.id)
  	@post = current_user.posts.build if user_signed_in?
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  		flash[:success] = "Posted"
  		redirect_to user_posts_path
  	else
  		render 'index'
  	end
  end

  private

  	def post_params
  		params.require(:post).permit(:content)
  	end
end
