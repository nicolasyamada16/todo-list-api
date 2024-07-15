source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.1', '>= 7.1.2'
gem 'bootsnap'
gem 'sprockets-rails'

# Use mysql2 as the database for Active Record
gem 'mysql2', '~> 0.5.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'
gem 'active_model_serializers', '~> 0.10.13'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1', '>= 3.1.18'

# API
gem 'active_model_serializers', '~> 0.10.13'
gem 'jwt'
gem 'base64'
gem 'rails-patterns'
gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'httparty', '~> 0.21'
gem 'pagy'
gem 'jera_push', '~> 2.0'
gem 'rack-cors', '~> 2.0', '>= 2.0.2'

# Facilities
gem 'devise', '~> 4.8', '>= 4.8.1'
gem "enumerize", "~> 2.7"
gem 'has_scope'
gem 'bullet'
gem "rexml"
gem 'rails_admin', '~> 3.0'
gem 'carrierwave', '~> 2.2', '>= 2.2.3'
gem 'carrierwave-aws', '~> 1.5'
gem 'mina'
gem 'newrelic_rpm', '~> 8.10'

# Sidekiq
gem 'sidekiq', '6.2.0'
gem 'sidekiq-status', '1.1.4'
gem 'redis', '4.2.5'

# Monitoring
gem 'sentry-rails', '~> 5.4', '>= 5.4.2'
gem 'sentry-ruby', '~> 5.4', '>= 5.4.2'

# Testing
gem 'webmock', '~> 3.18', '>= 3.18.1'


# Queue
gem 'sidekiq', '6.2.0'
gem 'sidekiq-cron', '1.1'
gem 'sidekiq-status', '1.1.4'
gem 'redis-namespace', '1.8.1'
gem 'redis', '4.2.5'

group :development, :test do
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'rubocop', '~> 1.39'
end

group :test do
  gem 'rspec-sidekiq'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'cucumber-rails', '~> 2.6', '>= 2.6.1', require: false
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.23'
  gem 'vcr', '~> 6.1'
  gem 'webmock', '~> 3.18', '>= 3.18.1'
end
