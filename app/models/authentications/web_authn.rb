class Authentications::WebAuthn < Authentication
  delegate :public_key, :sign_count, to: :properties

  alias_attribute :web_authn_id, :identifier

  def self.challenge_register(user)
    web_authn_id = WebAuthn.generate_user_id
    WebAuthn::Credential.options_for_create(
      user:    { id: web_authn_id, display_name: user.display_name, name: user.name },
      exclude: self.where(user: user).map(&:web_authn_id),
    ).tap do |options|
      self.set_register_challenge(user.uuid, options.challenge)
    end
  end

  def self.verify_register!(user, credential)
    web_authn_credential = WebAuthn::Credential.from_create(credential)
    web_authn_credential.verify(get_register_challenge(user.uuid))
    create!(
      user:         user,
      web_authn_id: web_authn_credential.id.to_s,
      properties:   {
        "public_key" => web_authn_credential.public_key.to_s,
        "sign_count" => web_authn_credential.sign_count.to_i,
      },
    )
  end

  def self.set_register_challenge(user_uuid, challenge)
    Rails.cache.write("webauthn::register::#{user_uuid}", challenge)
  end

  def self.get_register_challenge(user_uuid)
    Rails.cache.read("webauthn::register::#{user_uuid}")
  end
end
