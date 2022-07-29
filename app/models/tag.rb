class Tag < ApplicationRecord
  belongs_to :namespace
  has_many :post_tags
  has_many :posts, through: :post_tags

  validates_uniqueness_of :namespace_id, :slug
end
