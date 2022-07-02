module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :site, Types::SiteType do
      argument :slug, String, required: true
    end

    field :post, Types::PostType do
      argument :site, String, required: false
      argument :namespace, String, required: false
      argument :slug, String, required: false
      argument :uuid, String, required: false
      validates required: { one_of: [[:site, :namespace, :slug], :uuid] }
    end

    field :user, Types::UserType do
      argument :user_id, String, required: true
    end

    def site(slug:)
      Site.find_by(slug: slug)
    end

    def post(site: nil, namespace: nil, slug: nil, uuid: nil)
      return Post.find_by(uuid: uuid) if uuid.present?

      site      = Site.find_by(slug: site) or return nil
      namespace = Namespace.find_by(site: site, slug: namespace) or return nil
      Post.find_by(namespace: namespace, slug: slug)
    end

    def user(user_id:)
      User.find_by(user_id: user_id)
    end
  end
end
