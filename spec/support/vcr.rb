require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb

  config.ignore_hosts(
    'localhost',
    '127.0.0.1',
    '0.0.0.0',
    'api.knapsackpro.com',
    'api-fake.knapsackpro.com',
    'api-staging.knapsackpro.com',
    'api.knapsackpro.test',
    'api-disabled-for-fork.knapsackpro.com',
    'analytics-api.buildkite.com',
  )
end

require 'webmock/rspec'

WebMock.disable_net_connect!(allow: [
  'api.knapsackpro.com',
  'api-fake.knapsackpro.com',
  'api-staging.knapsackpro.com',
  'api.knapsackpro.test',
  'api-disabled-for-fork.knapsackpro.com',
]) if defined?(WebMock)
