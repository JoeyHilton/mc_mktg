require "selenium-webdriver"
require "rspec"
require "faker"
require "pry"
include RSpec::Expectations

RSpec.configure do |config|

	config.expect_with :rspec do |c|
	  c.syntax = [:should, :expect]
	end

	config.before(:each) do 
		@driver = Selenium::WebDriver.for :firefox
	end

	config.after(:each) do 
		@driver.quit
	end
end