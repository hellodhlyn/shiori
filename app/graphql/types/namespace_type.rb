class Types::NamespaceType < Types::Base::Object
  field :name, String, null: false
  field :slug, String, null: false
  field :site, Types::SiteType, null: false
  field :posts, Types::PostType.connection_type, null: false do
    argument :filter, Types::Inputs::PostFilter, required: false
  end
  field :tags, [Types::TagType], null: false

  def posts(filter:)
    posts = object.posts
    posts = filter.apply(posts) if filter.present?
    posts
  end
end
