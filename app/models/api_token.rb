class ApiToken
  attr_accessor :access_key, :refresh_key

  ACCESS_KEY_VALID_HOURS  = 7 * 24
  REFRESH_KEY_VALID_HOURS = 30 * 24

  JWT_ALGORITHM = "HS512"

  class KeyTypes
    ACCESS_KEY  = "access_key"
    REFRESH_KEY = "refresh_key"
  end

  def self.generate(user)
    ApiToken.new.tap do |token|
      token.access_key  = generate_jwt(
        { type: KeyTypes::ACCESS_KEY, user_id: user.uuid },
        ACCESS_KEY_VALID_HOURS.days.from_now,
      )
      token.refresh_key = generate_jwt(
        { type: KeyTypes::REFRESH_KEY, user_id: user.uuid },
        REFRESH_KEY_VALID_HOURS.days.from_now,
      )
    end
  end

  def self.validate_key(key, key_type)
    payload, _ = JWT.decode(key, secret, true, { algorithm: JWT_ALGORITHM })
    raise Exceptions::InvalidType.new unless payload["type"] == key_type

    payload["user_id"]
  rescue JWT::ExpiredSignature
    raise Exceptions::Expired.new
  rescue JWT::DecodeError => e
    Rails.logger.error(e)
    raise Exceptions::InvalidToken.new
  end

  private

  def self.secret
    Rails.application.secrets.api_token_secret
  end

  def self.generate_jwt(payload, valid_until)
    JWT.encode(payload, secret, JWT_ALGORITHM, {
      iat: Time.zone.now.to_i,
      exp: valid_until.to_i,
    })
  end

  module Exceptions
    class BaseException < Exception
    end

    class Expired < BaseException
      def initialize
        super("token expired")
      end
    end

    class InvalidToken < BaseException
      def initialize
        super("token invalid")
      end
    end

    class InvalidType < BaseException
      def initialize
        super("invalid token type")
      end
    end
  end
end
