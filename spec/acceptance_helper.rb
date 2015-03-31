require 'rails_helper'
require 'capybara/rails'
require 'capybara/poltergeist'

include Warden::Test::Helpers
Warden.test_mode!

def login_as_user(user = nil)
  @current_user = user || Factory.create(:user)
  login_as(@current_user, scope: :user, run_callbacks: false)
end

def pry!
  require 'pry'

  login = @current_user.email
  password = @current_user.password

  puts '=' * 100
  puts "login: #{login}, password: #{password}".center(100)
  puts current_url.center(100)
  puts '=' * 100

  binding.pry
end

RSpec.configure do |config|
  # Capybara driver
  Capybara.javascript_driver = :poltergeist

  # Include acceptance tests helpers
  config.include AcceptanceHelpers, type: :feature

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each, js: false) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset!
  end
end
