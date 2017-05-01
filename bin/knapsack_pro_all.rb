COMMANDS = %{
# RSpec
./bin/knapsack_pro_rspec 0 2
./bin/knapsack_pro_rspec 1 2

./bin/knapsack_pro_rspec_junit 0 2
./bin/knapsack_pro_rspec_junit 1 2

./bin/knapsack_pro_rspec_encrypted 0 2
./bin/knapsack_pro_rspec_encrypted 1 2

./bin/knapsack_pro_rspec_disabled 0 2
./bin/knapsack_pro_rspec_disabled 1 2

./bin/knapsack_pro_queue_rspec 0 2
./bin/knapsack_pro_queue_rspec 1 2

./bin/knapsack_pro_queue_rspec_default_formatter 0 2
./bin/knapsack_pro_queue_rspec_default_formatter 1 2

./bin/knapsack_pro_queue_rspec_profile_formatter 0 2
./bin/knapsack_pro_queue_rspec_profile_formatter 1 2

./bin/knapsack_pro_queue_rspec_junit 0 2
./bin/knapsack_pro_queue_rspec_junit 1 2

./bin/knapsack_pro_queue_rspec_initialized_once 0 2
./bin/knapsack_pro_queue_rspec_initialized_once 1 2

./bin/knapsack_pro_fixed_queue_split_rspec 0 2
./bin/knapsack_pro_fixed_queue_split_rspec 1 2

./bin/knapsack_pro_queue_rspec_encrypted 0 2
./bin/knapsack_pro_queue_rspec_encrypted 1 2

./bin/knapsack_pro_fixed_queue_split_rspec_encrypted 0 2
./bin/knapsack_pro_fixed_queue_split_rspec_encrypted 1 2

./bin/parallel_tests_knapsack_pro_queue_rspec 0 2
./bin/parallel_tests_knapsack_pro_queue_rspec 1 2

./bin/bin_knapsack_pro_rspec 0 2
./bin/bin_knapsack_pro_rspec 1 2

./bin/bin_knapsack_pro_queue_rspec 0 2
./bin/bin_knapsack_pro_queue_rspec 1 2

# Cucumber
./bin/knapsack_pro_cucumber 0 2
./bin/knapsack_pro_cucumber 1 2

# Minitest
./bin/knapsack_pro_minitest 0 2
./bin/knapsack_pro_minitest 1 2

# Spinach
./bin/knapsack_pro_spinach 0 2
./bin/knapsack_pro_spinach 1 2
}.split("\n").select { |i| i =~ /\A\.\/bin\// }


final_status = 0
failed_commands = []

COMMANDS.each do |command|
  system(command)
  unless $?.exitstatus == 0
    final_status = $?.exitstatus
    failed_commands << command
  end
end

puts
puts '='*20
puts
if final_status == 0
  puts 'All tests pass with success!'
else
  puts 'Something failed! You can retry those commands:'
  puts failed_commands
end
