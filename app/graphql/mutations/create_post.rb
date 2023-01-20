class Mutations::CreatePost < Mutations::Base::Mutation
  argument :site,          String, required: true
  argument :namespace,     String, required: true
  argument :title,         String, required: true
  argument :slug,          String, required: true
  argument :description,   String, required: false
  argument :thumbnail_url, String, required: false
  argument :blobs,         [Types::Inputs::BlobInput], required: true

  field :post, Types::PostType, null: false

  def resolve(site:, namespace:, title:, slug:, description: nil, thumbnail_url: nil, blobs:)
    site      = Site.find_by!(slug: site)
    namespace = site.namespaces.find_by!(slug: namespace)
    post      = namespace.posts.create!(
      title:         title,
      slug:          slug,
      description:   description,
      thumbnail_url: thumbnail_url,
      author:        context[:current_user],
      blobs:         blobs.map { |blob| Blob.create(type: blob.type, content: blob.content) },
    )

    { post: post }
  end
end
