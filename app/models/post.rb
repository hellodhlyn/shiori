class Post < ApplicationRecord
  include UuidGeneratable

  belongs_to :namespace
  belongs_to :author, class_name: "User"
  delegate :site, :to => :namespace

  def blobs
    PostBlob.where(post: self).includes(:blob).order(index: :asc).map(&:blob)
  end
end
