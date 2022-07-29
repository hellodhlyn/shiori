module Types
  class TagType < Types::Base::Object
    field :name, String, null: false
    field :slug, String, null: false
    field :posts, Types::PostType.connection_type, null: false
  end
end
