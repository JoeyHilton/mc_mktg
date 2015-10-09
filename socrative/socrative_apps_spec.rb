require "json"
require "selenium-webdriver"
require "rspec"
require_relative 'tabs'
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "SocrativeApps" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/socrative/"
    @driver.get(@base_url + @url_path)
    @driver.find_element(:link, "Apps").click
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end
  
  it "test_findmystate_link" do
    verify { (@driver.current_url).should == "https://www.masteryconnect.com/socrative/apps.html" }
    (@driver.find_element(:css, "h1").text).should == "Our Apps"

    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[2]/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    # @tabs.window_open(:xpath, "//*[@id='mc-apps']/div/div[2]/a")

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "MasteryConnect"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "MasteryConnect"
    (@driver.find_element(:xpath, "//*[@id='state_app_map']/div/h2").text).should == "All Your State Standards in One App"
  end

  it "tests_teacher_apple_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[1]/a[1]/img").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative Teacher on the App Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative Teacher on the App Store"
    (@driver.find_element(:xpath, "//*[@id='title']/div[1]/h1").text).should == "Socrative Teacher"
  end

  it "tests_teacher_chrome_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[1]/a[2]/img").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative Teacher - Chrome Web Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative Teacher - Chrome Web Store"
    # (@driver.find_element(:xpath, "//*[@id='title']/div[1]/h1").text).should == "Socrative Teacher"
  end

  it "tests_teacher_googleplay_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[1]/a[3]/img").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative Teacher - Android Apps on Google Play"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative Teacher - Android Apps on Google Play"
    (@driver.find_element(:xpath, "//*[@id='body-content']/div/div/div[1]/div[1]/div/div[1]/div/div[2]/h1/div").text).should == "Socrative Teacher"
  end

  it "tests_teacher_amazon_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[1]/div/a[1]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Amazon.com: Socrative Teacher: Appstore for Android"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Amazon.com: Socrative Teacher: Appstore for Android"
    (@driver.find_element(:xpath, "//*[@id='btAsinTitle']").text).should == "Socrative Teacher"
  end

  it "tests_teacher_windows_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[1]/div/a[2]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative – Windows Apps on Microsoft Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative – Windows Apps on Microsoft Store"
    (@driver.find_element(:xpath, "//*[@id='page-title']").text).should == "Socrative"
  end

  it "tests_student_apple_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[2]/a[1]/img").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative Student on the App Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative Student on the App Store"
    (@driver.find_element(:xpath, "//*[@id='title']/div[1]/h1").text).should == "Socrative Student"
  end

  it "tests_student_chrome_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[2]/a[2]/img").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative Student - Chrome Web Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative Student - Chrome Web Store"
    # (@driver.find_element(:xpath, "//*[@id='title']/div[1]/h1").text).should == "Socrative Teacher"
  end

  it "tests_student_googleplay_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[2]/a[3]/img").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Socrative Student - Android Apps on Google Play"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Socrative Student - Android Apps on Google Play"
    (@driver.find_element(:xpath, "//*[@id='body-content']/div/div/div[1]/div[1]/div/div[1]/div/div[2]/h1/div").text).should == "Socrative Student"
  end

  it "tests_student_amazon_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='apps']/div/div/div[2]/div/a[1]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Amazon.com: Socrative Student: Appstore for Android"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Amazon.com: Socrative Student: Appstore for Android"
    (@driver.find_element(:xpath, "//*[@id='btAsinTitle']").text).should == "Socrative Student"
  end

  it "tests_common_core_apple_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[1]/div[2]/div/a[1]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Common Core Standards on the App Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Common Core Standards on the App Store"
    (@driver.find_element(:xpath, "//*[@id='title']/div[1]/h1").text).should == "Common Core Standards"
  end

  it "tests_common_core_android_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[1]/div[2]/div/a[2]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Common Core - Android Apps on Google Play"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Common Core - Android Apps on Google Play"
    (@driver.find_element(:xpath, "//*[@id='body-content']/div/div/div[1]/div[1]/div/div[1]/div/div[2]/h1/div").text).should == "Common Core"
  end

  it "tests_common_core_amazon_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[1]/div[2]/div/a[3]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Amazon.com: Common Core: Appstore for Android"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Amazon.com: Common Core: Appstore for Android"
    (@driver.find_element(:xpath, "//*[@id='btAsinTitle']").text).should == "Common Core"
  end

  it "tests_common_core_windows_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[1]/div[2]/div/a[4]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Common Core Standards – Windows Apps on Microsoft Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Common Core Standards – Windows Apps on Microsoft Store"
    (@driver.find_element(:xpath, "//*[@id='page-title']").text).should == "Common Core Standards"
  end

  it "tests_ngss_apple_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[3]/div[2]/div/a[1]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Next Generation Science Standards on the App Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Next Generation Science Standards on the App Store"
    (@driver.find_element(:xpath, "//*[@id='title']/div[1]/h1").text).should == "Next Generation Science Standards"
  end

  it "tests_ngss_android_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[3]/div[2]/div/a[2]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Next Gen Science Standards - Android Apps on Google Play"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Next Gen Science Standards - Android Apps on Google Play"
    (@driver.find_element(:xpath, "//*[@id='body-content']/div/div/div[1]/div[1]/div/div[1]/div/div[2]/h1/div").text).should == "Next Gen Science Standards"
  end

  it "tests_ngss_amazon_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[3]/div[2]/div/a[3]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Amazon.com: Next Generation Science Standards: Appstore for Android"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Amazon.com: Next Generation Science Standards: Appstore for Android"
    (@driver.find_element(:xpath, "//*[@id='btAsinTitle']").text).should == "Next Generation Science Standards"
  end

  it "tests_common_core_windows_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='mc-apps']/div/div[3]/div[2]/div/a[4]/i").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql "Next Generation Science Standards – Windows Apps on Microsoft Store"

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql "Next Generation Science Standards – Windows Apps on Microsoft Store"
    (@driver.find_element(:xpath, "//*[@id='page-title']").text).should == "Next Generation Science Standards"
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
