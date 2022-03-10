class Namespace < ApplicationRecord
  validates_uniqueness_of :slug
  belongs_to :site
  has_many :posts
end
