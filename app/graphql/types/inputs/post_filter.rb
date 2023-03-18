class Types::Inputs::PostFilter < Types::Base::InputObject
  argument :tags, [String], required: false

  def apply(query)
    query = query.joins(:tags).where(tags: { slug: tags }) if tags.present?
    query
  end
end
