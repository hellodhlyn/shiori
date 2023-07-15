module Queries
  class PostQuery < Queries::BaseQuery
    type Types::PostType, null: true

    argument :site, String, required: false
    argument :namespace, String, required: false
    argument :slug, String, required: false
    argument :uuid, String, required: false
    validates required: { one_of: [[:site, :namespace, :slug], :uuid] }

    def resolve(site: nil, namespace: nil, slug: nil, uuid: nil)
      return post_clazz.find_by(uuid: uuid) if uuid.present?

      site      = Site.find_by(slug: site) or return nil
      namespace = Namespace.find_by(site: site, slug: namespace) or return nil
      post_clazz.find_by(namespace: namespace, slug: slug)
    end

    private

    def post_clazz
      current_user.present? ? Post.with_private : Post
    end
  end
end
