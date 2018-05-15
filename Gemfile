# frozen_string_literal: true

# You *must* specify versions for each dependency (this is a Hack Club
# convention, not an actual technical requirement)
source 'https://rubygems.org'

gem 'rails', '~> 5.2.0.rc1'

gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.0'

gem 'active_model_serializers', '~> 0.10.2'
gem 'analytics-ruby', require: 'segment'
gem 'aws-sdk-s3', '~> 1.8', '>= 1.8.2'
gem 'chronic', '~> 0.10.2'
gem 'concurrent-ruby', require: 'concurrent'
gem 'faker', '~> 1.6'
gem 'geocoder', '~> 1.4'
gem 'lograge', '~> 0.10.0'
gem 'mimemagic', '~> 0.3'
gem 'mini_magick', '~> 4.8'
gem 'octokit', '~> 4.7'
gem 'paranoia', '~> 2.4'
gem 'pdfkit', '~> 0.8.2'
gem 'pundit', '~> 1.1'
gem 'rack-cors', require: 'rack/cors'
gem 'redcarpet', '~> 3.4.0'
gem 'redis-rails', '~> 5.0.2'
gem 'rest-client', '~> 2.0'
gem 'sentry-raven', '~> 2.4'
gem 'sidekiq', '~> 5.0', '>= 5.0.5'
gem 'skylight', '~> 1.5', '>= 1.5.1'
gem 'stripe', '~> 3.0'
gem 'terminal-table', '~> 1.7'
gem 'timezone', '~> 1.0'
gem 'wkhtmltopdf-binary', '~> 0.12.3'

group :development, :test do
  gem 'listen', '~> 3.0.5'

  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'byebug', platform: :mri
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
  gem 'email_spec', '~> 2.1', '>= 2.1.1'
  gem 'factory_bot_rails', '~> 4.7', '>= 4.7.0'
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
  gem 'vcr', '~> 3.0'
  gem 'webmock', '~> 2.1'

  gem 'shoulda-matchers', '~> 3.1'

  # Use Guard for a great test workflow
  gem 'guard-rspec', '~> 4.7', require: false

  # Allow formatting rspec test results in junit's format, giving CircleCI
  # better insight into tests
  gem 'rspec_junit_formatter', '~> 0.3.0'

  # For test coverage reports on Codacy
  gem 'codacy-coverage', '~> 1.1', '>= 1.1.8', require: false

  gem 'rubocop', '~> 0.52.1', require: false
end

gem 'gruff'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

ruby '2.3.1'
