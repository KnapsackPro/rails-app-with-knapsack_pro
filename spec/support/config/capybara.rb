#require 'capybara/webkit'
#require 'selenium-webdriver'

#Capybara::Webkit.configure do |config|
  #config.allow_unknown_urls
#end

#Capybara.default_driver = :rack_test

RSpec.configure do |config|
  config.before(:each) do |example|
    #puts Capybara.current_driver
    #Capybara.current_driver = :selenium if example.metadata[:js]
    #puts Capybara.current_driver
  end

  config.after(:each) do |example|
    #Capybara.use_default_driver if example.metadata[:js]
    puts "default: #{Capybara.current_driver}"
  end
end
