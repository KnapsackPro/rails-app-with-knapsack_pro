require 'async/rspec'

require 'knapsack_pro'

#KnapsackPro::Hooks::Queue.after_subset_queue do |queue_id, subset_queue_id|
  #puts '\\'*100
  #puts 'Executed tests for a batch of tests fetched from Queue API'
  #Dir.glob(".knapsack_pro/queue/#{queue_id}/*.json").each do |file|
    #report = JSON.parse(File.read(file))
    #puts report.inspect
  #end
  #puts '/'*100
#end

#KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  #puts '\\'*100
  #puts 'Summary of all executed tests'
  #Dir.glob(".knapsack_pro/queue/#{queue_id}/*.json").each do |file|
    #report = JSON.parse(File.read(file))
    #puts report.inspect
  #end
  #puts '/'*100
#end

# uncomment if you want to test how custom logger works
#require 'logger'
#KnapsackPro.logger = Logger.new(STDOUT)
#KnapsackPro.logger.level = Logger::INFO

require 'simplecov'
SimpleCov.start


before_suite_block = proc {
  puts '+'*100
  puts 'RSpec before suite hook called only once'
}

unless KnapsackPro::Config::Env.queue_recording_enabled?
  RSpec.configure do |config|
    config.before(:suite) do
      before_suite_block.call
      puts 'Run this only when not using Knapsack Pro Queue Mode'
    end
  end
end

KnapsackPro::Hooks::Queue.before_queue do |queue_id|
  before_suite_block.call
  puts 'Run this only when using Knapsack Pro Queue Mode'
  puts 'This code is executed within the context of RSpec before(:suite) hook'
end


after_suite_block = proc {
  puts '+'*100
  puts 'after suite hook called only once'
}

unless KnapsackPro::Config::Env.queue_recording_enabled?
  RSpec.configure do |config|
    config.after(:suite) do
      after_suite_block.call
      puts 'Run this only when not using Knapsack Pro Queue Mode'
    end
  end
end

KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  after_suite_block.call
  puts 'Run this only when using Knapsack Pro Queue Mode'
  puts "This code is executed outside of the RSpec after(:suite) hook context because it's impossible to determine which after(:suite) is the last one to execute until it's executed."
end


# CUSTOM_CONFIG_GOES_HERE
KnapsackPro::Hooks::Queue.before_queue do |queue_id|
  print '-'*10
  print 'Before Queue Hook - run before test suite'
  print '-'*10
  puts

  SimpleCov.command_name("rspec_ci_node_#{KnapsackPro::Config::Env.ci_node_index}")
end
KnapsackPro::Hooks::Queue.before_queue do |queue_id|
  puts '2nd KnapsackPro::Hooks::Queue.before_queue'
end

KnapsackPro::Hooks::Queue.before_subset_queue do |queue_id, subset_queue_id|
  print '-'*10
  print 'Before Subset Queue Hook - run before the subset of the test suite'
  print '-'*10
  puts
end
KnapsackPro::Hooks::Queue.before_subset_queue do |queue_id, subset_queue_id|
  puts '2nd KnapsackPro::Hooks::Queue.before_subset_queue'
end

# TODO This must be the same path as value for rspec --out argument
TMP_RSPEC_XML_REPORT = "tmp/test-reports/rspec/queue_mode/rspec_#{KnapsackPro::Config::Env.ci_node_index}.xml"
TMP_RSPEC_JSON_REPORT = "tmp/test-reports/rspec/queue_mode/rspec_#{KnapsackPro::Config::Env.ci_node_index}.json"
# move results to FINAL_RSPEC_XML_REPORT so the results won't accumulate with duplicated xml tags in TMP_RSPEC_XML_REPORT
FINAL_RSPEC_XML_REPORT = "tmp/test-reports/rspec/queue_mode/rspec_final_results_#{KnapsackPro::Config::Env.ci_node_index}.xml"
FINAL_RSPEC_JSON_REPORT = "tmp/test-reports/rspec/queue_mode/rspec_final_results_#{KnapsackPro::Config::Env.ci_node_index}.json"

KnapsackPro::Hooks::Queue.after_subset_queue do |queue_id, subset_queue_id|
  if File.exist?(TMP_RSPEC_XML_REPORT)
    FileUtils.mv(TMP_RSPEC_XML_REPORT, FINAL_RSPEC_XML_REPORT)
  end

  if File.exist?(TMP_RSPEC_JSON_REPORT)
    FileUtils.mv(TMP_RSPEC_JSON_REPORT, FINAL_RSPEC_JSON_REPORT)
  end

  print '-'*10
  print 'After Subset Queue Hook - run after the subset of the test suite'
  print '-'*10
  puts
end
KnapsackPro::Hooks::Queue.after_subset_queue do |queue_id, subset_queue_id|
  puts '2nd KnapsackPro::Hooks::Queue.after_subset_queue'
end

KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  # Metadata collection
  # https://circleci.com/docs/1.0/test-metadata/#metadata-collection-in-custom-test-steps
  if File.exist?(FINAL_RSPEC_XML_REPORT) && ENV['CIRCLE_TEST_REPORTS']
    FileUtils.cp(FINAL_RSPEC_XML_REPORT, "#{ENV['CIRCLE_TEST_REPORTS']}/rspec.xml")
  end

  print '-'*10
  print 'After Queue Hook - run after test suite'
  print '-'*10
  puts
end
KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  puts '2nd KnapsackPro::Hooks::Queue.after_queue'
end

KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  THE_SLOWEST_TEST_FILE_TIME_EXECUTION_LIMIT = 3 # in seconds

  # all recorded test files by knapsack_pro gem
  test_files = []
  Dir.glob(".knapsack_pro/queue/#{queue_id}/*.json").each do |file|
    report = JSON.parse(File.read(file))
    test_files += report
  end

  slowest_test_file = test_files.max_by do |test_file|
    test_file['time_execution']
  end

  if slowest_test_file && slowest_test_file['time_execution'].to_f > THE_SLOWEST_TEST_FILE_TIME_EXECUTION_LIMIT
    puts '!'*50
    puts "The slowest test file took #{slowest_test_file['time_execution']} seconds and exceeded allowed max limit: #{THE_SLOWEST_TEST_FILE_TIME_EXECUTION_LIMIT} seconds. File path: #{slowest_test_file['path']}"
    puts '!'*50

    File.open('tmp/slowest_test_file_exceeded_allowed_limit.txt', 'w+') do |f|
      f.write(slowest_test_file.to_json)
    end
  end
end

KnapsackPro::Adapters::RSpecAdapter.bind

if ENV['KNAPSACK_PRO_RSPEC_SPLIT_BY_TEST_EXAMPLES']
  puts '+'*100
  if ENV['CUSTOM_VARIABLE_FOR_RSPEC_TEST_EXAMPLE_DETECTOR']
    # use the following bin script to test this scenario:
    # bin/knapsack_pro_queue_rspec_split_by_test_examples_test_example_detector_prefix
    # test following env var should be set only when running RSpec in dry run by knapsack_pro:rspec_test_example_detector rake task to generate test examples JSON report
    puts "CUSTOM_VARIABLE_FOR_RSPEC_TEST_EXAMPLE_DETECTOR=#{ENV['CUSTOM_VARIABLE_FOR_RSPEC_TEST_EXAMPLE_DETECTOR']}"
  else
    # use the following bin script to test this scenario:
    # bin/knapsack_pro_queue_rspec_split_by_test_examples
    puts "CUSTOM_VARIABLE_FOR_RSPEC_TEST_EXAMPLE_DETECTOR is not set"
  end
end

RSpec.configure do |config|
  config.around(:each) do |example|
    #sleep 1 # time tracked
    puts 'around each start'
    example.run
    puts 'around each stop'
  end

  config.before(:suite) do
    #sleep 1 # time not tracked
    puts "before suite"
  end

  config.before(:all) do
    #sleep 1 # time not tracked
    puts "before all"
  end

  config.before(:each) do
    #sleep 1 # time tracked
    puts "before each"
  end

  config.after(:each) do
    puts "after each"
  end

  config.after(:all) do
    puts "after all"
  end

  config.after(:suite) do
    puts "after suite"
  end
end

# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # Uncomment for testing purposes
  # https://knapsackpro.com/faq/question/rspec-is-not-running-some-tests
  # https://knapsackpro.com/faq/question/how-to-split-slow-rspec-test-files-by-test-examples-by-individual-it#warning-dont-use-deprecated-rspec-run_all_when_everything_filtered-option
  #config.filter_run_when_matching :focus
  #config.filter_run :focus
  #config.run_all_when_everything_filtered = true
  #config.filter_run_including :focus => true
  #config.filter_run_including :focus2 => true
  # unless ENV['CI']
  #   config.filter_run_when_matching :focus
  # end

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  # This is deprecated, DO NOT USE IT
  # https://knapsackpro.com/faq/question/how-to-split-slow-rspec-test-files-by-test-examples-by-individual-it#warning-dont-use-deprecated-rspec-run_all_when_everything_filtered-option
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
  #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://myronmars.to/n/dev-blog/2014/05/notable-changes-in-rspec-3#new__config_option_to_disable_rspeccore_monkey_patching
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end

# Debugging: RSpec hangs / freezes
# https://github.com/rspec/rspec-rails/issues/1353#issuecomment-93173691
puts "rspec pid: #{Process.pid}"

trap 'USR1' do
  threads = Thread.list

  puts
  puts "=" * 80
  puts "Received USR1 signal; printing all #{threads.count} thread backtraces."

  threads.each do |thr|
    description = thr == Thread.main ? "Main thread" : thr.inspect
    puts
    puts "#{description} backtrace: "
    puts thr.backtrace.join("\n")
  end

  puts "=" * 80
end
