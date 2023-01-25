class Blob < ApplicationRecord
  include UuidGeneratable

  belongs_to :post, required: false
end
