class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friend_requests, dependent: :destroy
	has_many :sent_requests, through: :friend_requests, source: :friend
	has_many :inverse_request, class_name: 'FriendRequest', foreign_key: :friend_id
	has_many :pending_requests, through: :inverse_request, source: :user

	has_many :friendships, foreign_key: :user_id, dependent: :destroy
	has_many :active_friendships, through: :friendships, source: :friend
	has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
	has_many :inactive_friendships, through: :inverse_friendships, source: :user

	has_many :posts, foreign_key: :author_id
	has_many :likes
	has_many :comments, foreign_key: :author_id
end
