require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "SocrativeTopNav" do

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

  it "tests_apps_link" do 
    @driver.find_element(:link, "Apps").click
    @driver.current_url.should == "https://www.masteryconnect.com//socrative/apps.html"
    @driver.navigate.back
  end

  it "tests_resources_link" do
    @driver.find_element(:link, "Resources").click
    @driver.current_url.should == "https://www.masteryconnect.com//socrative/resources.html"
    @driver.navigate.back
  end

  it "tests_help_link" do 
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='main_nav']/ul/li[3]/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'Socrative Help Center'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'Socrative Help Center'
    @driver.current_url.should == "http://help.socrative.com/"
    (@driver.find_element(:xpath, "//*[@id='site']/a").text).should == "Help Center"
  end

  it "tests_student_teacher_login_buttons" do 
    @driver.find_element(:id, "s_login").click
    element_present?(:xpath, "//div[@id='student-login-container']/div[3]").should be true
    verify { (@driver.current_url).should == "https://b.socrative.com/login/student/" }
    @driver.navigate.back
    @driver.find_element(:xpath, "//nav[@id='main_nav']/ul/li[5]/a/button").click
    element_present?(:xpath, "//*[@id='teacherLoginForm']").should be true
    verify { (@driver.current_url).should == "https://b.socrative.com/login/teacher/" }
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

describe "ResourcesPage" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/socrative/resources.html"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end

  it "tests_apps_link" do 
    @driver.find_element(:xpath, "//*[@id='main_nav']/ul/li[4]/a/button").click
    @driver.current_url.should == "https://b.socrative.com/login/teacher/#register-teacher"
    (@driver.find_element(:xpath, "//*[@id='teacherRegForm']/div[1]/h3").text).should == "NEW ACCOUNT"
    @driver.navigate.back
  end

  it "tests_user_guide_link" do
    first_window = @driver.window_handle
    @driver.find_element(:css, "i.icon-user").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'SocrativeUserGuide.pdf'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'SocrativeUserGuide.pdf'
    @driver.current_url.should == "https://www.masteryconnect.com//socrative/materials/SocrativeUserGuide.pdf"
  end

  # it "tests_training_pack_link" do
  #   first_window = @driver.window_handle
  #   @driver.find_element(:css, "i.icon-book").click
  #   all_windows = @driver.window_handles
  #   new_window = all_windows.select { |this_window| this_window != first_window }

  #   @driver.switch_to.window(first_window)
  #   expect(@driver.title).not_to eql 'SocrativeUserGuide.pdf'

  #   @driver.switch_to.window(new_window)
  #   expect(@driver.title).to eql 'SocrativeUserGuide.pdf'
  #   @driver.current_url.should == "https://www.masteryconnect.com//socrative/materials/SocrativeUserGuide.pdf"
  # end

  it "tests_videos_link" do
    @driver.find_element(:css, "i.icon-play-circle-fill").click
    expect(@driver.title).to eql 'SocrativeVideos - YouTube'
    @driver.current_url.should == "https://www.youtube.com/user/SocrativeVideos"
    @driver.navigate.back
  end

  it "tests_blog_link" do
    @driver.find_element(:css, "i.icon-feather").click
    expect(@driver.title).to eql 'Socrative Garden | Growing 21st Century Skills'
    @driver.current_url.should == "http://garden.socrative.com/"
    @driver.navigate.back
  end

  it "tests_checkitout_button" do
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='main_content']/section[2]/div[2]/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect'
    @driver.current_url.should == "https://www.masteryconnect.com/?utm_source=web_app_socrative&utm_medium=link&utm_content=from-resources&utm_campaign=socrative-referral"
  end

  it "tests_defense_article_link" do
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='rss-feeds']/ul/section[1]/div/div[2]/p/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'In Defense of Multiple Choice | Socrative Garden'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'In Defense of Multiple Choice | Socrative Garden'
    @driver.current_url.should == "http://garden.socrative.com/?p=1501"
    (@driver.find_element(:xpath, "//*[@id='post-1501']/h2").text).should == "In Defense of Multiple Choice"
  end

  it "tests_create_article_link" do
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='rss-feeds']/ul/section[2]/div/div[2]/p/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'How to Create Valuable Multiple Choice Questions | Socrative Garden'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'How to Create Valuable Multiple Choice Questions | Socrative Garden'
    @driver.current_url.should == "http://garden.socrative.com/?p=1688"
    (@driver.find_element(:xpath, "//*[@id='post-1688']/h2").text).should == "How to Create Valuable Multiple Choice Questions"
  end

  it "tests_quick_activity_article_link" do
    first_window = @driver.window_handle
    @driver.find_element(:xpath, "//*[@id='rss-feeds']/ul/section[3]/div/div[2]/p/a").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'Week 1 – A Quick Activity to Help Students Learn about their School | Socrative Garden'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'Week 1 – A Quick Activity to Help Students Learn about their School | Socrative Garden'
    @driver.current_url.should == "http://garden.socrative.com/?p=1551"
    (@driver.find_element(:xpath, "//*[@id='post-1551']/h2").text).should == "Week 1 – A Quick Activity to Help Students Learn about their School"
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