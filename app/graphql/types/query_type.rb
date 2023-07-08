module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :post, resolver: Resolvers::PostResolver
    field :site, resolver: Resolvers::SiteResolver
    field :sites, resolver: Resolvers::SitesResolver
    field :user, resolver: Resolvers::UserResolver
    field :viewer, resolver: Resolvers::ViewerResolver
  end
end
