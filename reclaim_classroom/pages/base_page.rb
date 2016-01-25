class BasePage

	def initialize(driver)
		@driver = driver
	end

	def visit(url_path)
		@driver.get ENV['base_url'] + url_path
	end

	def find(locator)
		@driver.find_element locator
	end

	def type(text, locator)
		find(locator).send_keys text
	end

	def submit(locator)
		find(locator).submit
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

	def select_dropdown(selector, tag, option)
	  dropdown = @driver.find_element(selector, tag)
	  select_list = Selenium::WebDriver::Support::Select.new(dropdown)
	  select_list.select_by(:text, option)
	end

	def select_dropdown_index(selector, tag, option)
	  dropdown = @driver.find_element(selector, tag)
	  select_list = Selenium::WebDriver::Support::Select.new(dropdown)
	  select_list.select_by(:index, option)
	end

	def click(how, what)
		@driver.find_element(how, what).click
	end

	def wait_for(seconds = 15)
		Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
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