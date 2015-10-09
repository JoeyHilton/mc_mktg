include RSpec::Expectations

class ButtonClick

	def initialize(driver)
		@driver = driver
		@driver.get ENV['base_url'] + '/in-app-messaging/otm-new-york/'
	end

	def successful_link
		@driver.find_element(:id, "button1").click
	end
end