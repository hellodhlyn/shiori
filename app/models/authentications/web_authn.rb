class Authentications::WebAuthn < Authentication
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

  def self.challenge_authentication(user)
    WebAuthn::Credential.options_for_get(allow: self.where(user: user).map(&:web_authn_id)).tap do |options|
      self.set_authentication_challenge(user.uuid, options.challenge)
    end
  end

  def self.verify_authentication!(user, credential)
    web_authn_credential = WebAuthn::Credential.from_get(credential)
    authentication       = self.find_by!(web_authn_id: web_authn_credential.id)

    web_authn_credential.verify(
      get_authentication_challenge(user.uuid),
      public_key: authentication.public_key,
      sign_count: authentication.sign_count,
    )

    authentication.update!(sign_count: web_authn_credential.sign_count.to_i)
    authentication.user
  end

  def public_key
    properties["public_key"]
  end

  def sign_count
    properties["sign_count"]
  end

  def public_key=(value)
    properties["public_key"] = value
  end

  def sign_count=(value)
    properties["sign_count"] = value
  end

  private

  def self.set_register_challenge(user_uuid, challenge)
    Rails.cache.write("webauthn::register::#{user_uuid}", challenge)
  end

  def self.get_register_challenge(user_uuid)
    Rails.cache.read("webauthn::register::#{user_uuid}")
  end

  def self.set_authentication_challenge(user_uuid, challenge)
    Rails.cache.write("webauthn::authentication::#{user_uuid}", challenge)
  end

  def self.get_authentication_challenge(user_uuid)
    Rails.cache.read("webauthn::authentication::#{user_uuid}")
  end
end
