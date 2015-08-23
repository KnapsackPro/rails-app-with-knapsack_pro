require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE
KnapsackPro::Client::Connection.credentials.set = {
  # token for cucumber test suite
  test_suite_token: '123',

  # KNAPSACK_PRO_ENDPOINT is set in circle.yml so we use different endpoint when running tests on CI server
  endpoint: ENV['KNAPSACK_PRO_ENDPOINT'] || 'http://api.knapsackpro.dev:3000'
}

KnapsackPro::Adapters::CucumberAdapter.bind
