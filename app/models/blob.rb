class Blob < ApplicationRecord
  include UuidGeneratable
  include GlobalID::Identification

  belongs_to :post, -> { with_private }, required: false

  delegate :author, :visible?, to: :post
end
