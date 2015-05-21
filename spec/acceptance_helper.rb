require 'rails_helper'
require 'capybara/rails'
require 'capybara/poltergeist'

include Warden::Test::Helpers
Warden.test_mode!

def login_as_user(user = nil)
  @current_user = user || Factory.create(:user)
  login_as(@current_user, scope: :user, run_callbacks: false)
end

RSpec.configure do |config|
  # Capybara driver
  Capybara.register_driver :poltergeist do |app|
    cnf = { debug: false, window_size: [1440, 900] }
    Capybara::Poltergeist::Driver.new(app, cnf)
  end
  Capybara.javascript_driver = :poltergeist

  # Include acceptance tests helpers
  config.include AcceptanceHelpers, type: :feature

  config.after(:each) do
    Warden.test_reset!
  end
end
