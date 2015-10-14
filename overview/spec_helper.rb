require 'selenium-webdriver'

RSpec.configure do |config|

	config.before(:each) do 
		# @base_url = "https://www-staging.masteryconnect.com/"
		@accept_next_alert = true
		@driver.manage.timeouts.implicit_wait = 30
		@verification_errors = []
		@url_path = "/overview/#"
		@driver.get(@base_url + @url_path)
		
		case ENV['browser']
		when 'firefox'
			@driver = Selenium::WebDriver.for :firefox
		when 'chrome'
			Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd,
'vendor/chromedriver')
			@driver = Selenium::WebDriver.for :chrome
		end
			
	end

	config.after(:each) do 
		@driver.quit
	end
end