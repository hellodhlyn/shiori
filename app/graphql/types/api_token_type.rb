class Types::ApiTokenType < Types::Base::Object
  field :access_key,  String, null: false
  field :refresh_key, String, null: false
end
