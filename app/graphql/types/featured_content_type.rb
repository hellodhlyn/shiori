class Types::FeaturedContentType < Types::Base::Object
  field :title,       String, null: false
  field :slug,        String, null: false
  field :description, String

  field :posts, resolver: Resolvers::PostsResolver
end
