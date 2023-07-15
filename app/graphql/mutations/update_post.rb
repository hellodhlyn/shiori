class Mutations::UpdatePost < Mutations::Base::Mutation
  argument :id,            ID,     required: true
  argument :title,         String, required: false
  argument :description,   String, required: false
  argument :thumbnail_url, String, required: false
  argument :visibility,    Types::Enums::PostVisibility, required: false
  argument :tags,          [String], required: false
  argument :blobs,         [Types::Inputs::BlobInput], required: false

  field :post, Types::PostType, null: false

  def resolve(id:, title: nil, description: nil, thumbnail_url: nil, visibility: nil, tags: nil, blobs: nil)
    raise GraphQL::ExecutionError.new("Unauthorized") unless current_user.present?

    post = GlobalID::Locator.locate_signed(id)
    raise GraphQL::ExecutionError.new("Not found") unless post.author == current_user

    attrs = {
      title:         title,
      description:   description,
      thumbnail_url: thumbnail_url,
      visibility:    visibility,
      tags:          tags.present? ? Tag.where(namespace: post.namespace, slug: tags) : [],
    }.compact

    if blobs.present?
      new_blobs = blobs.each_with_index.map do |blob, index|
        blob_obj   = GlobalID::Locator.locate_signed(blob.id)
        blob_obj ||= Blob.new(type: blob.type)

        blob_obj.index   = index
        blob_obj.content = blob.content
        blob_obj
      end
      attrs[:blobs] = new_blobs if new_blobs.present?
    end

    post.update!(attrs)

    { post: post }
  end
end
