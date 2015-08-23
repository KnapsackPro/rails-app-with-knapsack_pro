# Rails app with knapsack_pro gem

[![Circle CI](https://circleci.com/gh/KnapsackPro/rails-app-with-knapsack_pro.svg)](https://circleci.com/gh/KnapsackPro/rails-app-with-knapsack_pro)

This is example Ruby on Rails app with knapsack_pro gem. Knapsack Pro splits tests across CI nodes and makes sure that tests will run comparable time on each node.

__You can read more about [knapsack_pro gem here](https://github.com/KnapsackPro/knapsack_pro-ruby). You will find there info how to set up your test suite and how to do it on your favorite CI server.__


## How to load knapsack_pro rake tasks

See [Rakefile](Rakefile).


## Parallel rspec test suite with knapsack_pro

### How to set up knapsack_pro

See [spec/spec_helper.rb](spec/spec_helper.rb)

You can use below command on CI to run tests:

    # Run this on first CI server
    $ KNAPSACK_PRO_CI_NODE_TOTAL=2 KNAPSACK_PRO_CI_NODE_INDEX=0 bundle exec rake knapsack_pro:rspec

    # Run this on second CI server
    $ KNAPSACK_PRO_CI_NODE_TOTAL=2 KNAPSACK_PRO_CI_NODE_INDEX=1 bundle exec rake knapsack_pro:rspec

See [circle.yml](circle.yml) to see how we set up CircleCI.


## Parallel cucumber test suite with knapsack_pro

### How to set up knapsack_pro

See [features/support/knapsack_pro.rb](features/support/knapsack_pro.rb)

You can use below command on CI to run tests:

    # Run this on first CI server
    $ KNAPSACK_PRO_CI_NODE_TOTAL=2 KNAPSACK_PRO_CI_NODE_INDEX=0 bundle exec rake knapsack_pro:cucumber

    # Run this on second CI server
    $ KNAPSACK_PRO_CI_NODE_TOTAL=2 KNAPSACK_PRO_CI_NODE_INDEX=1 bundle exec rake knapsack_pro:cucumber

See [circle.yml](circle.yml) to see how we set up CircleCI.


## Parallel minitest test suite with knapsack_pro

### How to set up knapsack_pro

See [test/test_helper.rb](test/test_helper.rb)

You can use below command on CI to run tests:

    # Run this on first CI server
    $ KNAPSACK_PRO_CI_NODE_TOTAL=2 KNAPSACK_PRO_CI_NODE_INDEX=0 bundle exec rake knapsack_pro:minitest

    # Run this on second CI server
    $ KNAPSACK_PRO_CI_NODE_TOTAL=2 KNAPSACK_PRO_CI_NODE_INDEX=1 bundle exec rake knapsack_pro:minitest

See [circle.yml](circle.yml) to see how we set up CircleCI.
