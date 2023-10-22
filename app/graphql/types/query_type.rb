module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :post, resolver: Queries::PostQuery
    field :site, resolver: Queries::SiteQuery
    field :sites, resolver: Queries::SitesQuery
    field :featured_contents, resolver: Queries::FeaturedContentsQuery
    field :user, resolver: Queries::UserQuery
    field :viewer, resolver: Queries::ViewerQuery
  end
end
