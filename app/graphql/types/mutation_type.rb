module Types
  class MutationType < Types::Base::Object
    field :create_api_token, mutation: Mutations::CreateApiToken
    field :refresh_api_token, mutation: Mutations::RefreshApiToken
  end
end
