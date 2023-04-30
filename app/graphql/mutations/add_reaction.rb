class Mutations::AddReaction < Mutations::Base::Mutation
  argument :post_id, ID,     required: true
  argument :content, String, required: true

  field :reaction, Types::ReactionType, null: false

  def resolve(post_id:, content:)
    validate_authorized!

    post = GlobalID::Locator.locate_signed(post_id)
    raise GraphQL::ExecutionError.new("Post not found") unless post.present?

    reaction = Reaction.create(user: current_user, post: post, content: content)
    { reaction: reaction }
  end
end
