ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'

require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE
KnapsackPro::Hooks::Queue.before_queue do |queue_id|
  print '-'*10
  print 'Before Queue Hook - run before test suite'
  print '-'*10
end

KnapsackPro::Hooks::Queue.after_subset_queue do |queue_id, subset_queue_id|
  print '-'*10
  print 'After Subset Queue Hook - run after subset of test suite'
  print '-'*10
end

KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  print '-'*10
  print 'After Queue Hook - run after test suite'
  print '-'*10
end

knapsack_pro_adapter = KnapsackPro::Adapters::MinitestAdapter.bind
knapsack_pro_adapter.set_test_helper_path(__FILE__)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  extend MiniTest::Spec::DSL

  register_spec_type(self) do |desc|
    desc < ActiveRecord::Base if desc.is_a?(Class)
  end
end

class Minitest::SharedExamples < Module
  include Minitest::Spec::DSL
end

SharedExampleSpec = Minitest::SharedExamples.new do
  def setup
    sleep 0.1
  end

  def test_mal
    sleep 0.1
    assert_equal 4, 2 * 2
  end

  def test_no_way
    sleep 0.2
    refute_match(/^no/i, 'yes')
  end

  def test_that_will_be_skipped
    skip 'test this later'
  end
end
