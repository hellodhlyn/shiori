class Mutations::UpdateBlob < Mutations::Base::Mutation
  argument :id,      ID,     required: true
  argument :content, String, required: false

  field :blob, Types::BlobType, null: false

  def resolve(id:, content: nil)
    raise GraphQL::ExecutionError.new("Unauthorized") unless current_user.present?

    blob = GlobalID::Locator.locate_signed(id)
    raise GraphQL::ExecutionError.new("Not found") unless blob.author == current_user

    if content.present?
      blob.update!(content: content)
    end

    { blob: blob }
  end
end
