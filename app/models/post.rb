class Post < ApplicationRecord
  include UuidGeneratable
  include GlobalID::Identification

  class Visibilities
    PUBLIC  = "public"
    PRIVATE = "private"
    UNLISTED = "unlisted"

    ALL = [PUBLIC, PRIVATE, UNLISTED]
  end

  belongs_to :namespace
  belongs_to :author, class_name: "User"
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :blobs, -> { order(index: :asc) }, autosave: true, dependent: :destroy
  has_many :reactions
  has_many :featured_content_posts
  has_many :featured_contents, through: :featured_content_posts
  delegate :site, :to => :namespace

  validates :visibility, inclusion: { in: Visibilities::ALL }

  default_scope { where(visibility: Visibilities::PUBLIC) }
  scope :with_invisible, -> { unscope(where: :visibility) }
  scope :with_unlisted, -> {
    unscope(where: :visibility).where(visibility: [Visibilities::PUBLIC, Visibilities::UNLISTED])
  }

  def visible?(user)
    (visibility == Visibilities::PUBLIC) || (author == user)
  end

  def blobs=(new_blobs)
    if blobs.present?
      new_blob_uuids = new_blobs.map(&:uuid)
      blobs.reject { |blob| new_blob_uuids.include?(blob.uuid) }.each(&:mark_for_destruction)
    end

    new_blobs.each_with_index { |blob, index| blob.index = index }
    super(new_blobs)
  end
end
