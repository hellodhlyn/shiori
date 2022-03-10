module Types
  class SiteType < Types::Base::Object
    field :name, String, null: false
    field :slug, String, null: false
    field :namespaces, [Types::NamespaceType], null: false
  end
end
