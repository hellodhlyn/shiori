class Types::ViewerType < Types::Base::Object
  field :name,              String, null: false
  field :display_name,      String, null: false
  field :email,             String, null: false
  field :profile_image_url, String

  field :posts, Types::PostType.connection_type

  def posts
    viewer.posts.with_private
  end

  private

  def viewer
    context[:current_user]
  end
end
