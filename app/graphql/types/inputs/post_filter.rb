class Types::Inputs::PostFilter < Types::Base::InputObject
  argument :tags, [String], required: false
  argument :title, Types::Inputs::StringFieldFilter, required: false
  argument :site, String, required: false
  argument :namespace, String, required: false

  def apply(query)
    query = query.joins(:tags).where(tags: { slug: tags }) if tags.present?
    query = title.apply(query, :title) if title.present?
    query = query.where(namespace: namespace_arg) if namespace.present?
    query
  end

  private

  def namespace_arg
    throw "site is required" unless site.present?
    @namespace_arg ||= Namespace.find_by(site: Site.find_by(slug: site), slug: namespace)
  end
end
