require "selenium-webdriver"
require "rspec"
require "faker"
require "pry"
require "colorize"
include RSpec::Expectations

RSpec.configure do |config|

	config.expect_with :rspec do |c|
	  c.syntax = [:should, :expect]
	end

	config.before(:each) do 
		case ENV['browser']
		when 'firefox'
			@driver = Selenium::WebDriver.for :firefox
		when 'chrome'
			Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd, 'vendor/chromedriver')
			@driver = Selenium::WebDriver.for :chrome
		when 'safari'
			@driver = Selenium::WebDriver.for :safari
		end
	end

	config.after(:each) do 
		@driver.quit
	end
end