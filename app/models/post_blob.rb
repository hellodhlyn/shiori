class PostBlob < ApplicationRecord
  belongs_to :post
  belongs_to :blob
end
