source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

gem 'pg'
gem 'pg_search'
gem 'redis'
gem 'sidekiq'
gem 'sidekiq-scheduler'
# gem 'mongoid', '~> 7.0.5'

gem 'clearance'
gem 'twilio-ruby'
gem 'money-rails'
gem 'slim-rails'

gem "image_processing", ">= 1.2"
gem 'asset_sync'
gem 'fog-aws'
gem 'aws-sdk-s3', require: false

gem 'newrelic_rpm'
gem 'google-analytics-rails', '1.1.1'

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'annotate'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
