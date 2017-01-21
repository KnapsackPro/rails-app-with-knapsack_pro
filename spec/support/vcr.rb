require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb

  config.ignore_hosts(
    'localhost',
    '127.0.0.1',
    '0.0.0.0',
    'api.knapsackpro.com',
    'api-staging.knapsackpro.com',
    'api.knapsackpro.dev',
  )
end

WebMock.disable_net_connect!(allow: [
  'api.knapsackpro.com',
  'api-staging.knapsackpro.com',
  'api.knapsackpro.dev',
]) if defined?(WebMock)
