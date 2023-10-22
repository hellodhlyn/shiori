class Queries::FeaturedContentsQuery < Queries::BaseQuery
  type [Types::FeaturedContentType], null: false

  argument :slugs, [String], required: false

  def resolve(slugs: nil)
    slugs.present? ? FeaturedContent.where(slug: slugs) : FeaturedContent.all
  end
end
