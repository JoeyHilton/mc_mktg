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

	def find_trenton
		puts "I found Trenton!" if wait.until {
		find(id: "trenton").css_value("background-image").should == "url(\"https://reclaimingtheclassroom.com/wp-content/themes/reclaim/img/trenton@2x.jpg\")"
		}
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

	def window_switch(selector, tag, url)
		first_window = @driver.window_handle
    @driver.find_element(selector, tag).click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)

    @driver.switch_to.window(new_window)
    # expect(@driver.title).to eql (title)
		(@driver.current_url).should == (url)
    @driver.close
    @driver.switch_to.window(first_window)
	end

end