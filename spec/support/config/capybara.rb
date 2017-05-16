#require 'capybara/webkit'
#require 'selenium-webdriver'

#Capybara::Webkit.configure do |config|
  #config.allow_unknown_urls
#end

Capybara.default_driver = :rack_test

RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_driver = :webkit if example.metadata[:js]
    Capybara.current_driver = :selenium if example.metadata[:selenium]
  end

  config.after(:each) do |example|
    Capybara.use_default_driver if example.metadata[:js] || example.metadata[:selenium]
  end
end
