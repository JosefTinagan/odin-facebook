class Post < ApplicationRecord
	has_many :likes
  has_many :liked_by, through: :likes, source: :user

  has_many :comments
  has_many :commented_by, through: :comments, source: :author

	belongs_to :author, class_name: 'User'
end
