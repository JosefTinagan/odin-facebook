class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  # Added before_action, for devise controller to enable sign up fields like name
  before_action :configure_permitted_parameters, if: :devise_controller?

  # To be able to use the methods in views
  helper_method :friend_request_sent?, :friend?, :liked?

  # Helper method to check if a user has requested a friend request already
  def friend_request_sent?(user,friend)
  	@friend_request = FriendRequest.where(user_id: user.id, friend_id: friend.id)
  	if !@friend_request.blank?
  		@friend_request.first
  	else
  		false
  	end
  end

  # Helper method to check if a user is a friend already
  def friend?(user,friend)
  	@friend = Friendship.where(user_id: user.id, friend_id: friend.id)
  	if !@friend.blank?
  		@friend.first
  	else
  		false
  	end
  end

  # Helper method to check if a user already liked a post
  def liked?(post)
    @like = Like.where(user_id: current_user.id, post_id: post.id)
    if !@like.blank?
      @like.first
    else
      false
    end
  end
 

  private
    # Added strong paramaters to let a name field, be accepeted
  	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  	end

end
