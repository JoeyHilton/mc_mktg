require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "Starbucks" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/free-coffee/"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end

  it "tests_element_presence" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    expect(@driver.title).to eql 'MasteryConnect'
    (@driver.find_element(:xpath, "//*[@id='mast']/div/h1").text).should == "Let’s chat,\nwe’ll get the coffee."
    puts "Found starbucks gift card image with the path 'images/starbucks_card.png'" if wait.until {
    @driver.find_element(:xpath, "//img[@src='images/starbucks_card.png']").displayed?
    }

    puts "MasteryConnect logo present in footer with path 'images/logo_vertical.svg'" if wait.until {
    @driver.find_element(:xpath, "//img[@src='images/logo_vertical.svg']").displayed?
    }

    puts "Background image of coffee present" if wait.until {
    # @driver.find_element(:xpath, "//img[@url='../images/header.jpg']").displayed?
    @driver.find_element(:id, "mast").css_value("background-image").should == "url(\"https://www.masteryconnect.com//free-coffee/images/header.jpg\")"
    }

    puts "Phone number is correct" if wait.until {
    @driver.find_element(:xpath, "html/body/footer/p").text.include? "Phone: (801) 736-0258"
    }
  end

  it "tests_request_form" do 
    @driver.find_element(:class, "more_info").click
    element_present?(:id, "more_info").should be true
    element_present?(:id, "submit").should be true

    @driver.find_element(:xpath, "//*[@id='first_name']").clear
    @driver.find_element(:xpath, "//*[@id='first_name']").send_keys "Otto"
    @driver.find_element(:xpath, "//*[@id='last_name']").send_keys "Test"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "otto@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:id, "submit").click

    element_present?(:id, "form_success").should be true
    element_present?(:xpath, "//*[@id='form_success']/h2/i").should be true
    verify { element_present?(:link, "OK, GOT IT").should be_true }

    first_window = @driver.window_handle
    @driver.find_element(:link, "MasteryConnect.com").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect (@MasteryConnect) | Twitter'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect'
    @driver.current_url.should == "https://www.masteryconnect.com/"
    @driver.close
    @driver.switch_to.window(first_window)
    @driver.find_element(:link, "OK, GOT IT").click
  end

  it "tests_empty_form_fields" do 
    @driver.find_element(:class, "more_info").click
    @driver.find_element(:id, "submit").click
    element_present?(:link, "OK, GOT IT").should_not be true
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