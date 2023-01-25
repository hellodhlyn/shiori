class Blob < ApplicationRecord
  include UuidGeneratable

  belongs_to :post, required: false

  def visible?(user)
    post.visible?(user)
  end
end
