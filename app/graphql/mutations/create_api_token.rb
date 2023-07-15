class Mutations::CreateApiToken < Mutations::BaseMutation
  class WebAuthnAuthenticationType < Types::Base::InputObject
    argument :username,   String
    argument :credential, String
  end

  class GithubAuthenticationType < Types::Base::InputObject
    argument :access_token, String
  end

  argument :web_authn, WebAuthnAuthenticationType, required: false
  argument :github,    GithubAuthenticationType,   required: false

  field :api_token,   Types::ApiTokenType, null: false
  field :user,        Types::UserType,     null: false

  def resolve(web_authn: nil, github: nil)
    if web_authn.present?
      user = User.find_by!(name: web_authn.username)
      Authentications::WebAuthn.verify_authentication!(user, JSON.parse(web_authn.credential))
    elsif github.present?
      Authentications::Github.authenticate!(github.access_token)
    else
      raise GraphQL::ExecutionError.new("No authentication provided")
    end => user

    {
      api_token: ApiToken.generate(user),
      user:      user,
    }
  end
end
