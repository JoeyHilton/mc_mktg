class BasePage

	def initialize(driver)
		@driver = driver
	end

	def visit(url_path)
		@driver.get ENV['base_url'] + url_path
	end

	def goto
		@driver.get ENV['base_url']
	end

	def find(locator)
		@driver.find_element locator
	end

	def finds(locator)
		@driver.find_elements locator
	end

	def current_url(url)
		(@driver.current_url).should == url
	end

	def is_displayed?(locator)
		begin
			find(locator).displayed?
		rescue Selenium::WebDriver::Error::NoSuchElementError
			false
		end
	end

	def go_back
		@driver.navigate.back
	end

	def page_title(title)
		(@driver.title).should == title
	end

	def speaker_page?
		current_url "http://www.masterycon.com/speakers/"
		page_title "Call for Speakers | MasteryCon Summer Camp"
	end

	def attend_page?
		current_url "http://www.masterycon.com/attend/"
		page_title "Why Attend | MasteryCon Summer Camp"
	end

	def lodging_page?
		current_url "http://www.masterycon.com/lodging/"
		page_title "Lodging | MasteryCon Summer Camp"
	end

	def register_page?
		current_url "https://www.eventbrite.com/e/masterycon16-tickets-18229516976"
		page_title "MasteryCon16 Tickets, Wed, Jul 27, 2016 at 9:00 AM | Eventbrite"
	end

	def click(how, what)
		@driver.find_element(how, what).click
	end

	def wait_for(seconds = 15)
		Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
	end

	def wait
		Selenium::WebDriver::Wait.new(:timeout => 15)
	end

end