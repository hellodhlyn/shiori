module Types
  class MutationType < Types::Base::Object
    # Authentications
    field :create_api_token, mutation: Mutations::CreateApiToken
    field :refresh_api_token, mutation: Mutations::RefreshApiToken

    # Posts
    field :create_post, mutation: Mutations::CreatePost
    field :update_post, mutation: Mutations::UpdatePost
  end
end
