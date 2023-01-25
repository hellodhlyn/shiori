require "global_id"

GlobalID.app            ||= (ENV["APP_NAME"] || "Shiori")
SignedGlobalID.verifier ||= GlobalID::Verifier.new(Rails.application.key_generator.generate_key("signed_global_id", 1))
