class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Association with FriendRequest Model
  has_many :friend_requests, dependent: :destroy
	has_many :sent_requests, through: :friend_requests, source: :friend
	has_many :inverse_request, class_name: 'FriendRequest', foreign_key: :friend_id
	has_many :pending_requests, through: :inverse_request, source: :user

	# Association with Friendship Model
	has_many :friendships, foreign_key: :user_id, dependent: :destroy
	has_many :active_friendships, through: :friendships, source: :friend
	has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
	has_many :inactive_friendships, through: :inverse_friendships, source: :user

	# Association with Post model
	has_many :posts, foreign_key: :author_id
	# Association with Like Model
	has_many :likes
	# Association with Comment Model
	has_many :comments, foreign_key: :author_id

	# Class method to get all the posts of the user and his/her friends
	def feed
		friend_ids = "SELECT friend_id FROM friendships WHERE user_id = :author_id"
		Post.where("author_id IN (#{friend_ids})
							 OR author_id = :author_id", author_id: id)
	end
end
