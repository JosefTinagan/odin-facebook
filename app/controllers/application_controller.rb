class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :friend_request_sent?

  def friend_request_sent?(potential_friend)
  	@friend_request = FriendRequest.where(user_id: current_user.id, friend_id: potential_friend.id)
  	if !@friend_request.blank?
  		@friend_request.first
  	else
  		false
  	end
  end

  private

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  	end

end
