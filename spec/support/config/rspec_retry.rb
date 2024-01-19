require 'rspec/retry'

RSpec.configure do |config|
  # show retry status in spec process
  config.verbose_retry = true
  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true

  # It's the RSpec option. When too many tests fail then the Knapsack Pro is terminated
  # config.fail_fast = 3

  # run retry only on features
  config.around :each, :js do |ex|
    ex.run_with_retry retry: 3
  end
end
