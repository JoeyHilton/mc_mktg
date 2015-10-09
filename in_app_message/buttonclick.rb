include RSpec::Expectations

class ButtonClick

	def initialize(driver)
		@driver = driver
		@driver.get ENV['base_url'] + '/in-app-messaging/otm-virginia'
	end

	def successful_link
		@driver.find_element(:link, "Get Event Info").click
	end
end