source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.1"

# Rails
gem "rails", "~> 7.0"
gem "graphql", "~> 2.0"

# Drivers
gem "pg", "~> 1.1"

# Web server
gem "puma", "~> 5.6"
gem "rack-cors", "~> 1.1"

# Security, Authentications
gem 'jwt'

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
