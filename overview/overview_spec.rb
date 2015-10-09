require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "OverviewSpec" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/overview/"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    @verification_errors = []
  end
  
  it "opens_closes_form_modal" do
    @driver.find_element(:link, "request a demo").click
    @driver.find_element(:css, "div.modal_close").click
  end

  it "scrolls_sections_plays_closes_videos" do 
    @driver.find_element(:xpath, "//li[2]/span").click
    @driver.find_element(:class, "video1_play").click
    @driver.find_element(:css, "#video1 > div.modal_close").click
    @driver.find_element(:xpath, "//li[3]/span").click
    @driver.find_element(:css, "a.video2_play.video_play > i.icon-playback-play").click
    @driver.find_element(:css, "#video2 > div.modal_close").click
    @driver.find_element(:xpath, "//li[4]/span").click
    @driver.find_element(:css, "a.btn-primary.video3_play").click
    @driver.find_element(:css, "#video3 > div.modal_close").click
  end

  it "fills_out_request_form" do 
      @driver.find_element(:xpath, "//li[5]/span").click
    # @driver.find_element(:link, "Request a Demo").click
    # @driver.find_element(:css, "#form_success > div.modal_close").click
    @driver.find_element(:class, "request_demo").click
    @driver.find_element(:id, "full_name").clear
    @driver.find_element(:id, "full_name").send_keys "mac firefox"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys "firefox@test.com"
    @driver.find_element(:id, "phone").clear
    @driver.find_element(:id, "phone").send_keys "111-222-3333"
    @driver.find_element(:id, "zip_code").clear
    @driver.find_element(:id, "zip_code").send_keys "84087"
    # ERROR: Caught exception [ERROR: Unsupported command [keyPress | id=zip_code | \9]]
    # ERROR: Caught exception [ERROR: Unsupported command [fireEvent | id=zip_code | blur]]
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click
    verify { element_present?(:link, "OK, GOT IT").should be_true }
    @driver.find_element(:link, "OK, GOT IT").click
  end

  it "verifies_link_to_mc.com" do 
      @driver.find_element(:link, "masteryconnect.com").click
    # ERROR: Caught exception [ERROR: Unsupported command [waitForPopUp |  | ]]
    # ERROR: Caught exception [ERROR: Unsupported command [selectPopUp |  | ]]
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/" }
    @driver.close
    # ERROR: Caught exception [ERROR: Unsupported command [selectWindow |  | ]]
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
