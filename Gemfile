source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.5"

gem "rails", "~> 7.0.1"
gem "sprockets-rails"
gem "sqlite3", "~> 1.7.2"
gem "puma", "~> 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'slim-rails'
gem "jsbundling-rails"
gem 'kaminari'
gem 'active_model_serializers'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "pry-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "annotate"
  gem "faker"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "factory_bot_rails"
  gem "rspec-its"
  gem "shoulda"
  gem "simplecov", require: false
  gem "rails-controller-testing"
end

# Use Redis for Action Cable
gem "redis", "~> 4.0"
