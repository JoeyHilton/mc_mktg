class Tabs

	def initialize
		@driver = driver
	end

	def window_open(method, selector)
		@first_window = @driver.window_handle
    @driver.find_element(method, selector).click
    @all_windows = @driver.window_handles
    @new_window = @all_windows.select { |this_window| this_window != @first_window }
	end
end