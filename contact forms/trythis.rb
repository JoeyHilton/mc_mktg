require "json"
require "selenium-webdriver"
require "rspec"
require "faker"
require "pry"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

def setup
  @driver = Selenium::WebDriver.for :firefox
end

def teardown
  @driver.quit
end

def run
  setup
  begin
    yield
  rescue RSpec::Expectations::ExpectationNotMetError => error
    puts error.message
    @driver.save_screenshot "./#{Time.now.strftime("failshot__%d_%m_%Y__%H_%M_%S")}.png"
  end
  teardown
end

run do
  def wait_for(seconds = 6)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end
  @driver.get("https://www.masteryconnect.com/request-a-demo.html")
  @driver.find_element(:name, "first_name").send_keys "Requestdemo"
  @driver.find_element(:name, "last_name").send_keys "Test"
  @driver.find_element(:name, "title").send_keys "Caesar"
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:class, "role")).select_by(:text, "Teacher")
  @driver.find_element(:name, "phone").send_keys "208-456-1237"
  @driver.find_element(:name, "email").send_keys Faker::Internet.email
  @driver.find_element(:id, "zip").send_keys "83713"
  wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
  # wait_for(10) { @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").displayed? }
  # Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "signUpSchool")).select_by(:text, "JOPLIN ELEMENTARY SCHOOL")
  @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[3]").click
  @driver.find_element(:class, "med_gry_rnd_btn").click
  (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
end