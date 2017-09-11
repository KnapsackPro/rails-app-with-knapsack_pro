ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'test/unit/rails/test_help'

require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE

#knapsack_pro_adapter = KnapsackPro::Adapters::TestUnitAdapter.bind
#knapsack_pro_adapter.set_test_helper_path(__FILE__)
