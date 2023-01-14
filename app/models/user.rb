class User < ApplicationRecord
  include UuidGeneratable

  has_many :posts, foreign_key: "author_id"
  has_many :authentications
end
