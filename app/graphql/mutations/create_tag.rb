class Mutations::CreateTag < Mutations::Base::Mutation
  argument :site,      String, required: true
  argument :namespace, String, required: true
  argument :slug,      String, required: true
  argument :name,      String, required: true

  field :tag, Types::TagType, null: false

  def resolve(site:, namespace:, slug:, name:)
    raise GraphQL::ExecutionError.new("Unauthorized") unless current_user.present?

    site      = Site.find_by!(slug: site)
    namespace = site.namespaces.find_by!(slug: namespace)
    tag       = namespace.tags.create!(slug: slug, name: name)

    { tag: tag }
  end
end
