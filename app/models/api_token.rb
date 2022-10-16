class ApiToken
  attr_accessor :access_key, :refresh_key

  ACCESS_KEY_VALID_HOURS  = 7 * 24
  REFRESH_KEY_VALID_HOURS = 30 * 24

  class KeyTypes
    ACCESS_KEY  = "access_key"
    REFRESH_KEY = "refresh_key"
  end

  def initialize(user)
    self.access_key  = generate_jwt(
      { type: KeyTypes::ACCESS_KEY, user_id: user.uuid },
      ACCESS_KEY_VALID_HOURS.days.from_now,
    )
    self.refresh_key = generate_jwt(
      { type: KeyTypes::REFRESH_KEY, user_id: user.uuid },
      REFRESH_KEY_VALID_HOURS.days.from_now,
    )
  end

  private

  def generate_jwt(payload, valid_until)
    JWT.encode(payload, Rails.application.secrets.api_token_secret, "HS512", {
      iat: Time.zone.now.to_i,
      exp: valid_until.to_i,
    })
  end
end
