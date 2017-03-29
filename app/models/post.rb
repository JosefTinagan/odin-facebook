class Post < ApplicationRecord
	has_many :likes
  has_many :liked_by, through: :likes, source: :user
	belongs_to :author, class_name: 'User'
end
