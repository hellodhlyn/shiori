class Mutations::RemoveReaction < Mutations::BaseMutation
  argument :post_id, ID,     required: true
  argument :content, String, required: true

  field :reaction, Types::ReactionType, null: true

  def resolve(post_id:, content:)
    validate_authorized!

    post = GlobalID::Locator.locate_signed(post_id)
    raise GraphQL::ExecutionError.new("Post not found") unless post.present?

    reaction = Reaction.find_by(user: current_user, post: post, content: content)
    reaction&.destroy
    { reaction: reaction }
  end
end
