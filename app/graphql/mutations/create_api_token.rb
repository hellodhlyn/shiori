class Mutations::CreateApiToken < Mutations::Base::Mutation
  class ProviderEnum < Types::Base::Enum
    value "lynlab"
  end

  argument :provider, ProviderEnum
  argument :token,    String

  field :access_key,  String, null: false
  field :refresh_key, String, null: false

  def resolve(provider:, token:)
    case provider
    when "lynlab"
      user = Authentications::Lynlab.get_or_create_user!(token)
      ApiToken.new(user)
    else
      raise "invalid provider: #{provider}"
    end
  end
end
