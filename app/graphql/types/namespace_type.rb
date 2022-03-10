module Types
  class NamespaceType < Types::Base::Object
    field :name, String, null: false
    field :slug, String, null: false
    field :site, Types::SiteType, null: false
    field :posts, Types::PostType.connection_type, null: false
  end
end
