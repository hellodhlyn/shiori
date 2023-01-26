module Types
  class PostType < Types::Base::Object
    implements GraphQL::Types::Relay::Node

    def self.authorized?(object, context)
      super && object.visible?(context[:current_user])
    end

    field :site, Types::SiteType, null: false
    field :namespace, Types::NamespaceType, null: false
    field :author, Types::UserType, null: false
    field :uuid, String, null: false
    field :slug, String, null: false
    field :title, String, null: false
    field :tags, [Types::TagType], null: false
    field :description, String
    field :thumbnail_url, String
    field :thumbnail_blurhash, String
    field :blobs, [Types::BlobType], null: false
    field :visibility, Types::Enums::PostVisibility, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
