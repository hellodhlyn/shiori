class Types::NamespaceType < Types::Base::Object
  field :name, String, null: false
  field :slug, String, null: false
  field :site, Types::SiteType, null: false
  field :posts, resolver: Resolvers::PostsResolver
  field :tags, [Types::TagType], null: false
end
