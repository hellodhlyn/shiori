module Types
  class TagType < Types::Base::Object
    field :name, String, null: false
    field :slug, String, null: false
    field :posts, resolver: Resolvers::PostsResolver
  end
end
