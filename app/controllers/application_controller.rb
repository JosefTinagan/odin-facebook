class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :friend_request_sent?, :friend?

  def friend_request_sent?(user,friend)
  	@friend_request = FriendRequest.where(user_id: user.id, friend_id: friend.id)
  	if !@friend_request.blank?
  		@friend_request.first
  	else
  		false
  	end
  end

  def friend?(user,friend)
  	@friend = Friendship.where(user_id: user.id, friend_id: friend.id)
  	if !@friend.blank?
  		@friend.first
  	else
  		false
  	end
  end
 

  private

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  	end

end
