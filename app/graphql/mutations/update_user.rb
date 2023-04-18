class Mutations::UpdateUser < Mutations::Base::Mutation
  argument :display_name,      String, required: false
  argument :profile_image_url, String, required: false
  argument :description,       String, required: false
  argument :website_url,       String, required: false

  field :user, Types::UserType, null: false

  def resolve(**args)
    raise GraphQL::ExecutionError.new("Unauthorized") unless current_user.present?
    current_user.update!(**args.compact)

    { user: current_user }
  end
end
