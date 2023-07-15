module Queries
  class SitesQuery < Queries::BaseQuery
    type [Types::SiteType], null: false

    def resolve = Site.all
  end
end
