class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, uniqueness: { scope: [:user, :post] }

  LIKE    = "👍"
  DISLIKE = "👎"
end
