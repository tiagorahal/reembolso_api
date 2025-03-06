source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.1"

# Use PostgreSQL as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server
gem "puma", ">= 5.0"

# Use Devise for authentication
gem "devise", "~> 4.9"

# Use Active Storage variants for image processing
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS)
gem "rack-cors"

# Windows-specific time zone support
gem "tzinfo-data", platforms: %i[windows jruby]

# Performance optimizations
gem "bootsnap", require: false

# Deploy as a Docker container
gem "kamal", require: false

# HTTP asset caching/compression for Puma
gem "thruster", require: false

# Database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "devise_token_auth"

gem "omniauth"
gem "omniauth-oauth2"

group :development, :test do
   gem 'database_cleaner-active_record'
   
  # Debugging tools
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Security analysis
  gem "brakeman", require: false

  # Ruby style guide enforcement
  gem "rubocop-rails-omakase", require: false

  # Testing and factories
  gem "rspec-rails", "~> 7.1"
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.5"
  gem "shoulda-matchers", "~> 6.4"

  gem 'database_cleaner-core', '~> 2.0.1'
end
