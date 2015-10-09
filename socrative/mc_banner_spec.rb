require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "MCbanner_on_help_page" do 

	before(:each) do
	  @driver = Selenium::WebDriver.for :firefox
	  @base_url = "http://help.socrative.com/"
	  @accept_next_alert = true
	  @driver.manage.timeouts.implicit_wait = 30
	  @verification_errors = []
	  @driver.get(@base_url)
	end

	after(:each) do
	  @driver.quit
	  # @verification_errors.should == []
	end

	it "tests_presence_of_elements" do
		element_present?(:class, "about_mc").should be true
		element_present?(:css, "div.mc_logo").should be true
		(@driver.find_element(:xpath, "html/body/div/section/div[2]/h3").text).should == "Did you know Socrative is just one of the K-12 solutions from MasteryConnect?"
		element_present?(:id, "visit_mc").should be true
	end

	it "tests_checkitout_button" do 
		first_window = @driver.window_handle
		@driver.find_element(:id, "visit_mc").click
		all_windows = @driver.window_handles
		new_window = all_windows.select { |this_window| this_window != first_window }

		@driver.switch_to.window(first_window)
		expect(@driver.title).not_to eql 'MasteryConnect'

		@driver.switch_to.window(new_window)
		expect(@driver.title).to eql 'MasteryConnect'
		@driver.current_url.should == "https://www.masteryconnect.com/?utm_source=web_app_socrative&utm_medium=link&utm_campaign=socrative-help"
		(@driver.find_element(:xpath, "//*[@id='cms-mainnav']/a/h1").text).should == "MasteryConnect"
	end

	def element_present?(how, what)
	  @driver.find_element(how, what)
	  true
	rescue Selenium::WebDriver::Error::NoSuchElementError
	  false
	end
	
	def alert_present?()
	  @driver.switch_to.alert
	  true
	rescue Selenium::WebDriver::Error::NoAlertPresentError
	  false
	end
	
	def verify(&blk)
	  yield
	rescue ExpectationNotMetError => ex
	  @verification_errors << ex
	end
	
	def close_alert_and_get_its_text(how, what)
	  alert = @driver.switch_to().alert()
	  alert_text = alert.text
	  if (@accept_next_alert) then
	    alert.accept()
	  else
	    alert.dismiss()
	  end
	  alert_text
	ensure
	  @accept_next_alert = true
	end

end