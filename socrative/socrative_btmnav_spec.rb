require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "SocrativeBtmnav" do

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
  
  it "test_socrative_btmnav" do
    @driver.find_element(:link, "Home").click
    (@driver.title).should == "Socrative"
    @driver.find_element(:link, "Blog").click
    (@driver.find_element(:css, "h1").text).should == "Socrative Garden"
    @driver.navigate.back
    @driver.find_element(:link, "Terms").click
    (@driver.current_url).should == "https://www.masteryconnect.com/socrative/terms.html"
    @driver.navigate.back
    @driver.find_element(:link, "Privacy").click
    (@driver.current_url).should == "https://www.masteryconnect.com/socrative/privacy.html"
    @driver.navigate.back
    @driver.find_element(:link, "Release Notes").click
    (@driver.current_url).should == "https://www.masteryconnect.com/socrative/release-notes.html"
    @driver.navigate.back
    @driver.find_element(:xpath, "//footer[@id='main_footer']/div/a/button").click
    (@driver.current_url).should == "https://b.socrative.com/login/teacher/#register-teacher"
    @driver.navigate.back
  end

  it 'tests_contact_form' do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.find_element(:link, "Contact").click
    wait.until { @driver.find_element(:xpath, "//aside[3]").displayed? }
    element_present?(:id, "help_submit").should be true
    (@driver.find_element(:xpath, "//aside[3]/div/header/h1").text).should == "Contact Us"
    @driver.find_element(:xpath, "//aside[3]/div/i").click
  end

  it "tests_help_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:link, "Help").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'Socrative Help Center'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'Socrative Help Center'
      @driver.current_url.should == "http://help.socrative.com/"
      (@driver.find_element(:xpath, "//*[@id='site']/a").text).should == "Help Center"
  end

  it "tests_twitter_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:css, "i.icon-twitter").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'Socrative (@Socrative) | Twitter'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'Socrative (@Socrative) | Twitter'
      @driver.current_url.should == "https://twitter.com/socrative"
  end

  it "tests_pinterest_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:css, "i.icon-pinterest").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'Socrative on Pinterest'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'Socrative on Pinterest'
      @driver.current_url.should == "https://www.pinterest.com/socrative/"
  end

  it "tests_facebook_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:css, "i.icon-facebook").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'Socrative on Pinterest'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'Socrative'
      @driver.current_url.should == "https://www.facebook.com/Socrative"
  end

  it "tests_youtube_link" do 
      first_window = @driver.window_handle
      @driver.find_element(:css, "i.icon-youtube").click
      all_windows = @driver.window_handles
      new_window = all_windows.select { |this_window| this_window != first_window }

      @driver.switch_to.window(first_window)
      expect(@driver.title).not_to eql 'Socrative on Pinterest'

      @driver.switch_to.window(new_window)
      expect(@driver.title).to eql 'SocrativeVideos - YouTube'
      @driver.current_url.should == "https://www.youtube.com/channel/UCZKuswVcSqijo0YbZTmFnxQ"
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
