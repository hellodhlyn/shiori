class Post < ApplicationRecord
  include UuidGeneratable

  class Visibilities
    PUBLIC  = "public"
    PRIVATE = "private"

    ALL = [PUBLIC, PRIVATE]
  end

  belongs_to :namespace
  belongs_to :author, class_name: "User"
  has_many :post_tags
  has_many :tags, through: :post_tags
  delegate :site, :to => :namespace

  validates :visibility, inclusion: { in: Visibilities::ALL }

  default_scope { where(visibility: Visibilities::PUBLIC).order(id: :asc) }

  def blobs
    PostBlob.where(post: self).includes(:blob).order(index: :asc).map(&:blob)
  end
end
