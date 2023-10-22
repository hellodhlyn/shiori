class Types:: PostType < Types::Base::Object
  implements GraphQL::Types::Relay::Node

  def self.authorized?(object, context)
    super && object.visible?(context[:current_user])
  end

  # PostType is related with many other types, which occurs circular dependency.
  # To avoid this, we define type of fields as string to load them lazily.
  field :site, "Types::SiteType", null: false
  field :namespace, "Types::NamespaceType", null: false
  field :author, "Types::UserType", null: false
  field :uuid, String, null: false
  field :slug, String, null: false
  field :title, String, null: false
  field :tags, "[Types::TagType]", null: false
  field :description, String
  field :thumbnail_url, String
  field :thumbnail_blurhash, String
  field :blobs, [Types::Interfaces::Blob], null: false
  field :visibility, Types::Enums::PostVisibility, null: false
  field :reaction_summary, "Types::ReactionSummaryType", null: false
  field :featured_contents, [Types::FeaturedContentType], null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  def reaction_summary
    ReactionSummary.new(object.reactions, viewer: current_user)
  end
end
