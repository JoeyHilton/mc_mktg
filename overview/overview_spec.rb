require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations
require_relative 'spec_helper'
require_relative 'overview'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "OverviewSpec" do

  before(:each) do
    @overview = Overview.new(@driver)
    # @driver = Selenium::WebDriver.for :firefox
    # @base_url = "https://www-staging.masteryconnect.com/"
    # @accept_next_alert = true
    # @driver.manage.timeouts.implicit_wait = 30
    # @verification_errors = []
    # @url_path = "/overview/#"
    # @driver.get(@base_url + @url_path)
  end
  
  # after(:each) do
  #   @driver.quit
  #   @verification_errors = []
  # end
  
  # it "opens_closes_form_modal" do
  #   @driver.find_element(:link, "request a demo").click
  #   @driver.find_element(:css, "div.modal_close").click
  # end

  it "scrolls_sections_plays_closes_videos" do 
    @driver.find_element(:xpath, "//*[@id='cta']/a").click
    wait_for(10) { @driver.find_element(:xpath, "//*[@id='last']/div/div/h2").displayed? }
    (@driver.find_element(:xpath, "//*[@id='last']/div/div/h2").text).should == "Fuel Student Growth"
    @driver.find_element(:xpath, "//li[1]/span").click
    wait_for(10) { @driver.find_element(:xpath, "//*[@id='home']/div/div/h1").displayed? }
    (@driver.find_element(:xpath, "//*[@id='home']/div/div/h1").text).should == "Student learning identified."

    @driver.find_element(:xpath, "//li[2]/span").click
    @driver.find_element(:class, "video1_play").click
    @driver.find_element(:css, "#video1 > div.modal_close").click
    @driver.find_element(:xpath, "//*[@id='question1']/div/div/div[1]/a/i").click
    @driver.find_element(:css, "#video1 > div.modal_close").click

    @driver.find_element(:xpath, "//*[@id='cta']/a").click
    @driver.find_element(:xpath, "//li[3]/span").click
    @driver.find_element(:css, "a.video2_play.video_play > i.icon-playback-play").click
    @driver.find_element(:css, "#video2 > div.modal_close").click
    @driver.find_element(:xpath, "//*[@id='question2']/div/div/div[1]/a/i").click
    @driver.find_element(:css, "#video2 > div.modal_close").click

    @driver.find_element(:xpath, "//*[@id='cta']/a").click
    @driver.find_element(:xpath, "//li[4]/span").click
    @driver.find_element(:css, "a.btn-primary.video3_play").click
    @driver.find_element(:css, "#video3 > div.modal_close").click
    @driver.find_element(:xpath, "//*[@id='question3']/div/div/div[1]/a/i").click
    @driver.find_element(:css, "#video3 > div.modal_close").click
  end

  it "fills_out_request_form" do 
      @driver.find_element(:xpath, "//li[5]/span").click
    # @driver.find_element(:link, "Request a Demo").click
    # @driver.find_element(:css, "#form_success > div.modal_close").click
    # @driver.find_element(:class, "request_demo").click
    @driver.find_element(:id, "full_name").clear
    @driver.find_element(:id, "full_name").send_keys "test firefox"
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

    verify { element_present?(:id, "form_success").should be_true }
    (@driver.find_element(:xpath, "//*[@id='form_success']/h2").text).should == "Thanks!"
    verify { element_present?(:xpath, "//*[@id='form_success']/p[2]/a").should be_true }

    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='form_success']/p[2]/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect'
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/?utm_source=web_app_masteryconnect&utm_medium=link&utm_campaign=overview" }
    @driver.close
    @driver.switch_to.window(first_window)

    verify { element_present?(:link, "OK, GOT IT").should be_true }
    @driver.find_element(:link, "OK, GOT IT").click
  end

  it "verifies_link_to_mc.com" do 
      @driver.find_element(:link, "masteryconnect.com").click
    # ERROR: Caught exception [ERROR: Unsupported command [waitForPopUp |  | ]]
    # ERROR: Caught exception [ERROR: Unsupported command [selectPopUp |  | ]]
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/?utm_source=web_app_masteryconnect&utm_medium=link&utm_campaign=overview" }
    @driver.close
    # ERROR: Caught exception [ERROR: Unsupported command [selectWindow |  | ]]
  end
  
end
