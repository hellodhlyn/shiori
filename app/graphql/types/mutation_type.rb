module Types
  class MutationType < Types::Base::Object
    # Authentications
    field :create_api_token, mutation: Mutations::CreateApiToken
    field :refresh_api_token, mutation: Mutations::RefreshApiToken

    field :challenge_web_authn_register, mutation: Mutations::ChallengeWebAuthnRegister
    field :challenge_web_authn_authentication, mutation: Mutations::ChallengeWebAuthnAuthentication
    field :create_web_authn_authentication, mutation: Mutations::CreateWebAuthnAuthentication

    # Posts
    field :create_post, mutation: Mutations::CreatePost
    field :update_post, mutation: Mutations::UpdatePost
    field :update_blob, mutation: Mutations::UpdateBlob
    field :create_tag, mutation: Mutations::CreateTag
    field :update_user, mutation: Mutations::UpdateUser

    # Reactions
    field :add_reaction, mutation: Mutations::AddReaction
    field :remove_reaction, mutation: Mutations::RemoveReaction
  end
end
