class FeaturedContentPost < ApplicationRecord
  belongs_to :featured_content
  belongs_to :post
end
