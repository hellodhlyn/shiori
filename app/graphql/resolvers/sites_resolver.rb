module Resolvers
  class SitesResolver < Resolvers::Base
    type [Types::SiteType], null: false

    def resolve = Site.all
  end
end
