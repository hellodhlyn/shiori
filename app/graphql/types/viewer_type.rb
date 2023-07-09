class Types::ViewerType < Types::Base::Object
  field :name,              String, null: false
  field :display_name,      String, null: false
  field :email,             String
  field :profile_image_url, String
  field :description,       String
  field :website_url,       String
  field :reactions,         Types::ReactionType.connection_type

  field :post, resolver: Resolvers::PostResolver
  field :posts, resolver: Resolvers::PostsResolver
end
