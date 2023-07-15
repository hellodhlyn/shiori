module Queries
  class SiteQuery < Queries::BaseQuery
    type Types::SiteType, null: true

    argument :slug, String, required: false

    def resolve(slug:) = Site.find_by(slug: slug)
  end
end
