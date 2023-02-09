require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Shiori
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    config.cache_store = :redis_cache_store, { url: ENV["REDIS_URL"] }
  end
end
