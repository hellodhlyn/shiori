class FeaturedContent < ApplicationRecord
  validates_uniqueness_of :slug

  has_many :featured_content_posts
  has_many :posts, through: :featured_content_posts
end
