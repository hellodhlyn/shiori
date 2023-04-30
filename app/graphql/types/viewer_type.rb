class Types::ViewerType < Types::Base::Object
  field :name,              String, null: false
  field :display_name,      String, null: false
  field :email,             String
  field :profile_image_url, String
  field :description,       String
  field :website_url,       String
  field :reactions,         Types::ReactionType.connection_type

  field :post, Types::PostType do
    argument :site, String, required: false
    argument :namespace, String, required: false
    argument :slug, String, required: false
    argument :uuid, String, required: false
    validates required: { one_of: [[:site, :namespace, :slug], :uuid] }
  end

  field :posts, Types::PostType.connection_type

  def post(site: nil, namespace: nil, slug: nil, uuid: nil)
    return Post.with_private.find_by(uuid: uuid, author: viewer) if uuid.present?

    site      = Site.find_by(slug: site) or return nil
    namespace = Namespace.find_by(site: site, slug: namespace) or return nil
    Post.with_private.find_by(namespace: namespace, slug: slug, author: viewer)
  end

  def posts
    viewer.posts.with_private
  end

  private

  def viewer
    context[:current_user]
  end
end
