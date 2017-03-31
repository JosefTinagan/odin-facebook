class Post < ApplicationRecord
	# Association with the Like model
	has_many :likes
  has_many :liked_by, through: :likes, source: :user

  # Association with the Comment Model
  has_many :comments
  has_many :commented_by, through: :comments, source: :author

  # Association with the User Model
	belongs_to :author, class_name: 'User'

	# added scope to arrange posts from newest to oldest
	default_scope -> { order(created_at: :desc) }
end
