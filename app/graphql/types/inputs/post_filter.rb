class Types::Inputs::PostFilter < Types::Base::InputObject
  argument :tags, [String], required: false
  argument :title, Types::Inputs::StringFieldFilter, required: false

  def apply(query)
    query = query.joins(:tags).where(tags: { slug: tags }) if tags.present?
    query = title.apply(query, :title) if title.present?
    query
  end
end
