class Mutations::CreateApiToken < Mutations::Base::Mutation
  class WebAuthnType < Types::Base::InputObject
    argument :username,   String, required: true
    argument :credential, String, required: true
  end

  argument :web_authn, WebAuthnType

  field :access_key,  String, null: false
  field :refresh_key, String, null: false

  def resolve(web_authn:)
    if web_authn.present?
      user = User.find_by!(name: web_authn.username)
      Authentications::WebAuthn.verify_authentication!(user, JSON.parse(web_authn.credential))
    else
      raise GraphQL::ExecutionError.new("No authentication provided")
    end => user

    ApiToken.generate(user)
  end
end
