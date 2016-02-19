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

	def mc_page?
		current_url "https://www.masteryconnect.com/"
		page_title "MasteryConnect"
	end

	def demo_page?
		current_url "https://www.masteryconnect.com/request-a-demo.html"
		page_title "Teachers Tools for Teaching | MasteryConnect"
	end

	def login_page?
		current_url "https://app.masteryconnect.com/login"
		page_title "MasteryConnect :: sessions"
	end

	def signup_page?
		current_url "https://docs.google.com/a/masteryconnect.com/forms/d/1wZmzkOCGjEa4W0wnCOCV8ciSb-iyjalDICGPoYP20T8/viewform"
		page_title "User Experience Research Sign-up"
	end

	def unsub_page?
		current_url "https://docs.google.com/a/masteryconnect.com/forms/d/19JhZ3UchvaZV8UzsbW0vHc50RHWDlg2sA1ODJEC2fMs/viewform"
		page_title "Unsubscribe from MasteryConnect User Experience Research"
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