require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "McComSocrativeHome" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/socrative/"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end
  
  it "verifies_presence_of_links" do
    (@driver.title).should == "Socrative"
    element_present?(:link, "Apps").should be true
    element_present?(:link, "Resources").should be true
    element_present?(:link, "Help").should be true
    element_present?(:id, "s_login").should be true
    element_present?(:xpath, "//nav[@id='main_nav']/ul/li[5]/a/button").should be true
    element_present?(:link, "GET A FREE ACCOUNT").should be true
    element_present?(:css, "img").should be true
    element_present?(:id, "visit_mc").should be true
    element_present?(:link, "Home").should be true
    element_present?(:link, "Blog").should be true
    element_present?(:link, "Contact").should be true
    element_present?(:link, "Terms").should be true
    element_present?(:link, "Privacy").should be true
    element_present?(:link, "Release Notes").should be true
    element_present?(:class, "icon-twitter").should be true
    element_present?(:class, "icon-pinterest").should be true
    element_present?(:class, "icon-facebook").should be true
    element_present?(:class, "icon-youtube").should be true
    element_present?(:id, "logo").should be true
  end

  it "tests_video_functionality" do 
    @driver.find_element(:link, "WATCH DEMO").click
    # element_present?(:xpath, "//*[@id='player']/div[2]").should be true
    @driver.find_element(:css, "i.icon-close.close").click
    # @driver.find_element(:xpath, "//div[@id='player']/div[5]/div[2]/button").click
    # @driver.find_element(:css, "i.icon-close.close").click
  end

  it "tests_howitworks_section" do 
    @driver.find_element(:link, "GET A FREE ACCOUNT").click
    verify { (@driver.current_url).should == "https://b.socrative.com/login/teacher/#register-teacher" }
    @driver.navigate.back
    @driver.find_element(:css, "h4.upp").click
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/socrative/features.html" }
    @driver.navigate.back
    @driver.find_element(:css, "div.circle.back > i.icon-share").click
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/socrative/features.html" }
    @driver.navigate.back
    @driver.find_element(:css, "div.circle.back > i.icon-line-graph").click
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/socrative/features.html" }
    @driver.navigate.back
    @driver.find_element(:css, "div.circle.back > i.icon-devices").click
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/socrative/features.html" }
    @driver.find_element(:id, "visit_mc").click
    verify { @driver.current_url.should == "https://www.masteryconnect.com/?utm_source=web_app_socrative&utm_medium=link&utm_content=from-features&utm_campaign=socrative-referral" }
    # @driver.close
    # @driver.navigate.back
  end

  it "tests_check_it_out_button" do 
      first_window = @driver.window_handle
      @driver.find_element(:id, "visit_mc").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral"
      (@driver.find_element(:css, "h2").text).should == "Full Feature Index"
  end

  it "tests_mastery_tracker_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:xpath, "//*[@id='main_content']/section[3]/div[2]/div/div[1]/a").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral#masterytracker"
      (@driver.find_element(:css, "h3.caps").text).should == "MASTERY TRACKER"
  end

  it "tests_common_assessments_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:xpath, "//*[@id='main_content']/section[3]/div[2]/div/div[2]/a").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral#assessment"
      (@driver.find_element(:css, "#assessment > div.inner > div.col-a > h3.caps").text).should == "COMMON ASSESSMENT\nCREATION & SHARING"
  end

  it "tests_resource_pins_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:xpath, "//*[@id='main_content']/section[3]/div[2]/div/div[3]/a").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral#pins"
      (@driver.find_element(:css, "#pins > div.inner > div.col-a > h3.caps").text).should == "RESOURCE PINS"
  end

  it "tests_learning_community_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:xpath, "//*[@id='main_content']/section[3]/div[2]/div/div[4]/a").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral#community"
      (@driver.find_element(:css, "#community > div.inner > div.col-a > h3.caps").text).should == "LEARNING COMMUNITY"
  end

  it "tests_grading_tools_link" do
      first_window = @driver.window_handle
      @driver.find_element(:xpath, "//*[@id='main_content']/section[3]/div[2]/div/div[5]/a").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral#grading"
      (@driver.find_element(:css, "#grading > div.inner > div.col-a > h3.caps").text).should == "GRADING TOOLS"
  end

  it "tests_reports_link" do
      first_window = @driver.window_handle
      @driver.find_element(:xpath, "//*[@id='main_content']/section[3]/div[2]/div/div[6]/a").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'MasteryConnect'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'MasteryConnect'
      @driver.current_url.should == "https://www.masteryconnect.com/features.html?utm_source=web_app_socrative&utm_medium=link&utm_content=from-home&utm_campaign=socrative-referral#reports"
      (@driver.find_element(:css, "#reports > div.inner > div.col-a > h3.caps").text).should == "REPORTS"
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
