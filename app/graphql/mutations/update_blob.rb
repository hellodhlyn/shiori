class Mutations::UpdateBlob < Mutations::Base::Mutation
  argument :id, ID, required: true
  argument :blob, Types::Inputs::BlobInput, required: true

  field :blob, Types::BlobType, null: false

  def resolve(id:, blob:)
    raise GraphQL::ExecutionError.new("Unauthorized") unless current_user.present?

    blob_obj = GlobalID::Locator.locate_signed(id)
    raise GraphQL::ExecutionError.new("Not found") unless blob_obj.author == current_user

    blob_obj.update!(content: blob.content)

    { blob: blob_obj }
  end
end
