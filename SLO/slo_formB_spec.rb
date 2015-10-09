require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "SloSpec" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/slo/formb.html"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end
  
  it "fills_out_form" do
    @driver.find_element(:id, "full_name").clear
    @driver.find_element(:id, "full_name").send_keys "Slo Test"
    @driver.find_element(:id, "zip_code").clear
    @driver.find_element(:id, "zip_code").send_keys "84087"
    # ERROR: Caught exception [ERROR: Unsupported command [keyPress | id=zip_code | \9]]
    # ERROR: Caught exception [ERROR: Unsupported command [fireEvent | id=zip_code | blur]]
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys "slo@test.com"
    @driver.find_element(:id, "phone").clear
    @driver.find_element(:id, "phone").send_keys "444-444-4444"
    @driver.find_element(:id, "submit").click
    verify { element_present?(:class, "icon-checkmark").should be_true }
  end

  it "plays_videos" do
    # @driver.get(@base_url + "/slo/formb.html")
    @driver.find_element(:id, "vid_real_data").click
    @driver.find_element(:css, "#video_real_data > div.modal_close").click
    @driver.find_element(:id, "vid_real_time").click
    @driver.find_element(:css, "#video_real_time > div.modal_close").click
    @driver.find_element(:id, "vid_real_easy").click
    @driver.find_element(:css, "#video_real_easy > div.modal_close").click
  end

  it "tests_bottom_nav_links" do
    # @driver.get(@base_url + "/slo/formb.html")
    @driver.find_element(:link, "@masteryconnect").click
    (@driver.title).should == "MasteryConnect (@MasteryConnect) | Twitter"
    verify { (@driver.current_url).should == "https://twitter.com/masteryconnect" }
    @driver.navigate.back
    @driver.find_element(:link, "Features").click
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/features.html" }
    verify { (@driver.find_element(:css, "h2").text).should == "Full Feature Index" }
    @driver.navigate.back
    @driver.find_element(:link, "Plans & Pricing").click
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/pricing.html" }
    verify { (@driver.find_element(:css, "h2").text).should == "Start Tracking Mastery!" }
    @driver.navigate.back
    @driver.find_element(:link, "Goodies").click
    (@driver.find_element(:css, "h2").text).should == "Apps, Buttons, Widgets & Goodies"
    @driver.navigate.back
    @driver.find_element(:link, "Videos").click
    (@driver.find_element(:css, "#video1 > h2").text).should == "Student learning identified."
    @driver.navigate.back
    @driver.find_element(:link, "Sign Up").click
    (@driver.find_element(:css, "h2").text).should == "Start Tracking Mastery!"
    @driver.navigate.back
    @driver.find_element(:link, "Press / News").click
    (@driver.find_element(:css, "h2").text).should == "Press / Newsroom"
    @driver.navigate.back
    @driver.find_element(:link, "Contact").click
    @driver.find_element(:css, "h2").text.should == "So Call Us, Maybe?"
    @driver.navigate.back
    @driver.find_element(:link, "High Impact Careers").click
    (@driver.find_element(:css, "h2").text).should == "Join Our Team"
    @driver.navigate.back
    @driver.find_element(:link, "Webinars").click
    (@driver.find_element(:css, "h2").text).should == "Free Webinars & Demos"
    @driver.navigate.back
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
