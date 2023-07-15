class Mutations::RefreshApiToken < Mutations::BaseMutation
  argument :refresh_key, String

  field :access_key,  String, null: false
  field :refresh_key, String, null: false

  def resolve(refresh_key:)
    user_id = ApiToken.validate_key(refresh_key, ApiToken::KeyTypes::REFRESH_KEY)
    user    = User.find_by!(uuid: user_id)
    ApiToken.generate(user)
  end
end
