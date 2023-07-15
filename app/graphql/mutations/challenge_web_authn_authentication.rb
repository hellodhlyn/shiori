class Mutations::ChallengeWebAuthnAuthentication < Mutations::BaseMutation
  argument :username, String, required: true

  field :options, String, null: false

  def resolve(username:)
    user = User.find_by!(name: username)
    { options: Authentications::WebAuthn.challenge_authentication(user).to_json }
  end
end
