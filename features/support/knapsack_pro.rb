require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE
KnapsackPro::Hooks::Queue.before_queue do |queue_id|
  print '-'*10
  print 'Before Queue Hook - run before test suite'
  print '-'*10

  puts
  puts 'Queue Batches:'
  puts KnapsackPro::Store::Server.client.queue_batches.inspect
end

KnapsackPro::Hooks::Queue.after_subset_queue do |queue_id, subset_queue_id|
  print '-'*10
  print 'After Subset Queue Hook - run after subset of test suite'
  print '-'*10

  puts
  puts 'Queue Batches:'
  puts KnapsackPro::Store::Server.client.queue_batches.inspect
end

KnapsackPro::Hooks::Queue.after_queue do |queue_id|
  print '-'*10
  print 'After Queue Hook - run after test suite'
  print '-'*10

  puts
  puts 'Queue Batches:'
  puts KnapsackPro::Store::Server.client.queue_batches.inspect
end

KnapsackPro::Adapters::CucumberAdapter.bind
