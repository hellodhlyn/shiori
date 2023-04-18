module Types
  class UserType < Types::Base::Object
    field :name,              String, null: false
    field :display_name,      String, null: false
    field :email,             String, null: false
    field :profile_image_url, String
    field :description,       String
    field :website_url,       String

    field :posts, Types::PostType.connection_type
  end
end
