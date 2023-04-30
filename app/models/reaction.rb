class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :post, uniqueness: { scope: :user }

  LIKE    = "👍"
  DISLIKE = "👎"
end
