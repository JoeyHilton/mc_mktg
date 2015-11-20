require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "mc.com split" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www-staging.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.get(@base_url)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end

  it "tests_ABC" do
  		a_count = 0
  		b_count = 0
  		c_count = 0

  		if (@driver.find_element(:xpath, "//*[@id='cms-mainnav']/div[2]/a[1]") && @driver.find_element(:link, "REQUEST DEMO")).displayed?
        # @driver.find_element(:id, "cms-mainnav").find_element(:xpath, './/*[contains(., "Join for Free")]').displayed?

  			puts "Version A displayed #{a_count += 1} times."
      elsif
        @driver.find_element(:id, "black_strip").displayed? == false

        puts "Version C displayed #{c_count += 1} times."

      else
        # puts "Version C displayed #{c_count =+ 1} times."
        puts "Try again"
  		end
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def rescue_exceptions
    begin
      yield
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      false
    end
  end

  def is_displayed?(locator = {})
    rescue_exceptions { @driver.find_element(locator).displayed? }
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