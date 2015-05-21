ruby '2.2.1'

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
gem 'responders'

# PostgreSQL
gem 'pg'

# Puma web-server
gem 'puma'

# Use SCSS for stylesheets
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'autoprefixer-rails'

# AngularJS
source 'https://rails-assets.org' do
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-bootstrap-datetimepicker'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-animate'
  gem 'rails-assets-angular-loading-bar'
  gem 'rails-assets-restangular'
  gem 'rails-assets-ng-sortable'
  gem 'rails-assets-ng-file-upload'
end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Template system
gem 'slim-rails'

# Simple Form
gem 'simple_form'

# Sorting and reordering a number of objects in a list
gem 'acts_as_list'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Authentification and authorization
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'cancancan'

# File uploader
gem 'carrierwave'
gem 'mini_magick'

group :development do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  # gem 'byebug'
  gem 'awesome_pry'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'quiet_assets'
  # gem 'rack-mini-profiler'
end

group :development, :test do
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  # RSpec
  gem 'rspec-rails'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
  gem 'coveralls', require: false
  gem 'fuubar', require: false

  # Acceptance
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
end

# Heroku
gem 'rails_12factor', group: :production
