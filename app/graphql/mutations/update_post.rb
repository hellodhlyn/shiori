class Mutations::UpdatePost < Mutations::Base::Mutation
  argument :id,            ID,     required: true
  argument :title,         String, required: false
  argument :description,   String, required: false
  argument :thumbnail_url, String, required: false
  argument :visibility,    Types::Enums::PostVisibility, required: false

  field :post, Types::PostType, null: false

  def resolve(id:, title: nil, description: nil, thumbnail_url: nil, visibility: nil)
    raise GraphQL::ExecutionError.new("Unauthorized") unless current_user.present?

    post = GlobalID::Locator.locate_signed(id)
    raise GraphQL::ExecutionError.new("Not found") unless post.author == current_user

    attrs = {
      title:         title,
      description:   description,
      thumbnail_url: thumbnail_url,
      visibility:    visibility,
    }.compact
    post.update!(attrs)

    { post: post }
  end
end
