module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :site, Types::SiteType do
      argument :slug, String, required: true
    end

    field :post, Types::PostType do
      argument :site, String
      argument :namespace, String
      argument :slug, String
      argument :uuid, String
      validates required: { one_of: [[:site, :namespace, :slug], :uuid] }
    end

    def site(slug:)
      Site.find_by(slug: slug)
    end

    def post(site:, namespace:, slug:, uuid:)
      return Post.find_by(uuid: uuid) if uuid.present?

      site      = Site.find_by(slug: site) or return nil
      namespace = Namespace.find_by(site: site, slug: namespace) or return nil
      Post.find_by(namespace: namespace, slug: slug)
    end
  end
end
