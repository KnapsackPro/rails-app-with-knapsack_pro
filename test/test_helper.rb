ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'

require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE
KnapsackPro::Client::Connection.credentials.set = {
  # token for minitest test suite
  test_suite_token: 'abc',

  # KNAPSACK_PRO_ENDPOINT is set in circle.yml so we use different endpoint when running tests on CI server
  endpoint: ENV['KNAPSACK_PRO_ENDPOINT'] || 'http://api.knapsackpro.dev:3000'
}

knapsack_pro_adapter = KnapsackPro::Adapters::MinitestAdapter.bind
knapsack_pro_adapter.set_test_helper_path(__FILE__)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
