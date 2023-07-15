module Resolvers
  class PostsResolver < Resolvers::BaseResolver
    type Types::PostType.connection_type, null: false

    argument :filter, Types::Inputs::PostFilter, required: false

    # @params [Types::Inputs::PostFilter] filter
    def resolve(filter: nil)
      posts = object.posts
      posts = posts.with_private  if current_user.present?
      posts = filter.apply(posts) if filter.present?
      posts
    end
  end
end
