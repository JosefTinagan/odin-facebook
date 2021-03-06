class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

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

	mount_uploader :avatar, AvatarUploader
	validate :avatar_size

	# Class method to get all the posts of the user and his/her friends
	def feed
		friend_ids = "SELECT friend_id FROM friendships WHERE user_id = :author_id"
		Post.where("author_id IN (#{friend_ids})
							 OR author_id = :author_id", author_id: id)
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			user.name = auth.info.name # assuming the user model has a name
			#user.image = auth.info.image # assuming the user model has an image
			# If you are using confirmable and the provider(s) you validate you use validate emails,
			# uncomment the line below to skip the confirmation emails
			# user.skip_confirmation
		end
	end

	private

		#Validate the size of an uploaded avatar
		def avatar_size
			if avatar.size > 5.megabytes
				errors.add(:avatar, "should be less than 5MB")
			end
		end
end
