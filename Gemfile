source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.2"

# Rails
gem "rails", "~> 7.0"
gem "graphql", "~> 2.0"

# Drivers
gem "pg", "~> 1.1"
gem "redis"
gem "hiredis"

# Web server
gem "puma", "~> 5.6"
gem "rack-cors", "~> 1.1"

# Utilities
gem "github-markup"
gem "commonmarker"

# Security, Authentications
gem "jwt"
gem "webauthn"

# External services
gem "faraday", "~> 2.2"

# Ruby extensions
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0"
  gem "factory_bot_rails"
  gem "faker"
  gem "timecop"
end

group :development do
end
