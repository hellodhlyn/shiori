WebAuthn.configure do |config|
  config.origin  = ENV["WEBAUTHN_ORIGIN"]  || "http://localhost:8787"
  config.rp_id   = ENV["WEBAUTHN_RP_ID"]   || "localhost"
  config.rp_name = ENV["WEBAUTHN_RP_NAME"] || ENV["APP_NAME"] || "Shiori CMS"
end
