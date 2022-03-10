class Site < ApplicationRecord
  validates_uniqueness_of :slug
  has_many :namespaces
end
