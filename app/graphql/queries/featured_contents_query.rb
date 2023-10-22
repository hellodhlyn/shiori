class Queries::FeaturedContentsQuery < Queries::BaseQuery
  type [Types::FeaturedContentType], null: false

  def resolve = FeaturedContent.all
end
