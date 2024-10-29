source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7'
gem 'pg'
gem 'tzinfo-data'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 2.2.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'async'
gem 'async-io'

# use a legacy version which supports Ruby 3.0
# we use this repo with Ruby 3.0 for testing the knapsack_pro gem
gem 'fiber-local', '1.0.0'

# Fix for Ruby 3.1.x
# https://stackoverflow.com/a/70500221/905697
# https://github.com/mikel/mail/pull/1439
# This can be removed after upgrade to Rails 7.x
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'

  gem 'parallel_tests'

  if ENV['USE_KNAPSACK_PRO_FROM_RUBYGEMS']
    gem 'knapsack_pro'
  else
    gem 'knapsack_pro', path: ENV['KNAPSACK_PRO_REPO_PATH'] || '../knapsack_pro-ruby'
    #gem 'knapsack_pro', github: 'KnapsackPro/knapsack_pro-ruby', branch: 'rspec-queue-mode-record-timing-fix'
  end

  gem 'test-unit-rails'

  gem 'listen'
end

group :test do
  gem 'rails-controller-testing'

  if ENV['KNAPSACK_PRO_RSPEC_DISABLED'] != 'true'
    gem 'rspec-rails', '~> 4.0.1'
    gem 'rspec_junit_formatter'
    gem 'rspec-retry'
    # use this if you want to test rspec-core
    # you need to checkout to proper rspec-core version tag v3.8.2
    #gem 'rspec-core', path: '../forked/rspec/rspec-core'
    gem 'async-rspec', require: false
  end

  #gem 'minitest-spec-rails'

  gem 'cucumber-rails', require: false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'

  gem 'spinach'
  gem 'timecop'
  gem 'vcr' # Needed to test https://github.com/KnapsackPro/knapsack_pro-ruby/pull/251
  gem 'webmock', require: false # Needed to test https://github.com/KnapsackPro/knapsack_pro-ruby/pull/251

  gem 'capybara'
  gem 'capybara-screenshot'
  #gem 'capybara-screenshot', github: 'ArturT/capybara-screenshot', branch: 'fix-reporter_module-loaded-twice'

  gem 'shared_should', require: false
  gem 'simplecov', require: false
end

gem "turnip", "~> 4.4"
gem 'juniter'
