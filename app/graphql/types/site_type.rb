module Types
  class SiteType < Types::Base::Object
    field :name, String, null: false
    field :slug, String, null: false
    field :namespaces, [Types::NamespaceType], null: false
    field :namespace, Types::NamespaceType do
      argument :slug, String, required: true
    end

    def namespace(slug:)
      @object.namespaces.find_by(slug: slug)
    end
  end
end
