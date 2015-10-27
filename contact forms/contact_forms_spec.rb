require "json"
require "selenium-webdriver"
require "rspec"
require "pry"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "SloFormA" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/slo/forma.html"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end
  
  it "fills_out_form" do
    @driver.find_element(:link, "GET MORE INFO").click
    @driver.find_element(:id, "first_name").clear
    @driver.find_element(:id, "first_name").send_keys "Slo"
    @driver.find_element(:id, "last_name").clear
    @driver.find_element(:id, "last_name").send_keys "TestA"
    @driver.find_element(:id, "zip_code").clear
    @driver.find_element(:id, "zip_code").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys "slo@test.com"
    @driver.find_element(:id, "phone").clear
    @driver.find_element(:id, "phone").send_keys "444-444-4444"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click
    @driver.find_element(:xpath, "//*[@id='form_success']/a").displayed?
    @driver.find_element(:css, "#form_success > div.modal_close").click
  end

  it "tests_school_not_listed_field" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.find_element(:link, "GET MORE INFO").click
    @driver.find_element(:id, "first_name").send_keys "Notlisted"
    @driver.find_element(:id, "last_name").send_keys "TestA"
    @driver.find_element(:id, "zip_code").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:id, "email").send_keys "notlisted@test.com"
    @driver.find_element(:id, "phone").send_keys "555-555-5555"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")
    wait.until {
    @driver.find_element(:id, "school_list_alt").displayed?
    }
    @driver.find_element(:id, "school_list_alt").send_keys "Starfleet Academy"
    @driver.find_element(:id, "submit").click
    @driver.find_element(:xpath, "//*[@id='form_success']/a").displayed?
    @driver.find_element(:css, "#form_success > div.modal_close").click
  end
end

describe "SloFormB" do

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
    @driver.find_element(:id, "full_name").send_keys "SloB Test"
    @driver.find_element(:id, "zip_code").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:id, "email").send_keys "sloB@test.com"
    @driver.find_element(:id, "phone").send_keys "444-444-4444"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click
    @driver.find_element(:class, "icon-checkmark").displayed?
  end

  it "tests_school_not_listed_fieldB" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.find_element(:id, "full_name").send_keys "Notlisted TestB"
    @driver.find_element(:id, "zip_code").send_keys "83713"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "District Administrator")
    @driver.find_element(:id, "email").send_keys "notlistedB@test.com"
    @driver.find_element(:id, "phone").send_keys "666-666-6666"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")
    wait.until {
    @driver.find_element(:id, "school_list_alt").displayed?
    }
    @driver.find_element(:id, "school_list_alt").send_keys "Hogwarts"
    @driver.find_element(:id, "submit").click
    @driver.find_element(:class, "icon-checkmark").displayed?
  end
end

describe "OverviewSpec" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www-staging.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/overview/#"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    @verification_errors = []
  end
 
  it "fills_out_request_form" do 
    @driver.find_element(:xpath, "//li[5]/span").click
    @driver.find_element(:id, "full_name").send_keys "overview test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:id, "email").send_keys "overview@test.com"
    @driver.find_element(:id, "phone").send_keys "111-222-3333"
    @driver.find_element(:id, "zip_code").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")

    if (@driver.find_element(:id, "school_list").text) == "WEST BOUNTIFUL SCHOOL"
      @driver.find_element(:id, "submit").click
    else
      Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    end
    
    @driver.find_element(:id, "submit").click

    verify { element_present?(:id, "form_success").should be_true }
    (@driver.find_element(:xpath, "//*[@id='form_success']/h2").text).should == "Thanks!"
    verify { element_present?(:xpath, "//*[@id='form_success']/p[2]/a").should be_true }
  end

  it "tests_school_not_listed_overview" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.find_element(:xpath, "//li[5]/span").click
    @driver.find_element(:id, "full_name").send_keys "notlistedoverview test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:id, "email").send_keys "notlistedoverview@test.com"
    @driver.find_element(:id, "phone").send_keys "111-222-3333"
    @driver.find_element(:id, "zip_code").send_keys "83713"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")

    wait.until {
    @driver.find_element(:id, "school_manual_input").displayed?
    }
    @driver.find_element(:id, "school_manual_input").send_keys "Imperial Academy"

    if (@driver.find_element(:id, "school_list").text) == "SCHOOL NOT LISTED"
      @driver.find_element(:id, "submit").click
    else
      Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")
    end
    
    @driver.find_element(:id, "submit").click

    verify { element_present?(:id, "form_success").should be_true }
    (@driver.find_element(:xpath, "//*[@id='form_success']/h2").text).should == "Thanks!"
    verify { element_present?(:xpath, "//*[@id='form_success']/p[2]/a").should be_true }
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
end

describe "McComRiddle" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @url_path = "/riddle/"
    @driver.get(@base_url + @url_path)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end

  it "tests_form_dropdown_from_yellow_pencil" do 
    @driver.find_element(:xpath, "//*[@id='yellow']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true

    @driver.find_element(:xpath, "//*[@id='answer']").clear
    @driver.find_element(:xpath, "//*[@id='answer']").send_keys "stamp"
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "riddle test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "riddle@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
    element_present?(:xpath, "//*[@id='riddle_right']/div[2]/img").should be true

    @driver.find_element(:xpath, "//*[@id='form_success']/div[1]").click
  end

  it "tests_notlisted_yellow_pencil" do 
    @driver.find_element(:xpath, "//*[@id='yellow']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true

    @driver.find_element(:xpath, "//*[@id='answer']").clear
    @driver.find_element(:xpath, "//*[@id='answer']").send_keys "stamp"
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "notlisted test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "riddlenotlisted@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")
    @driver.find_element(:id, "school_manual_input").send_keys "Clown College"
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
    element_present?(:xpath, "//*[@id='riddle_right']/div[2]/img").should be true

    @driver.find_element(:xpath, "//*[@id='form_success']/div[1]").click
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
end

describe "FreeCoffee" do

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

  it "tests_coffee_request_form" do 
    @driver.find_element(:class, "more_info").click
    element_present?(:id, "more_info").should be true
    element_present?(:id, "submit").should be true

    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "Coffee Test"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "coffee@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click

    element_present?(:id, "form_success").should be true
    element_present?(:xpath, "//*[@id='form_success']/h2/i").should be true
    verify { element_present?(:link, "OK, GOT IT").should be_true }
    @driver.find_element(:link, "OK, GOT IT").click
  end

  it "tests_coffee_notlisted_field" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.find_element(:class, "more_info").click
    element_present?(:id, "more_info").should be true
    element_present?(:id, "submit").should be true

    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "Coffeenolist Test"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "83713"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "District Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "coffeenolist@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "333-222-1111"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")
    
    wait.until {
    @driver.find_element(:id, "school_list_alt").displayed?
    }
    @driver.find_element(:id, "school_list_alt").send_keys "Marky Mark and the Funky Bunch"

    @driver.find_element(:id, "submit").click

    element_present?(:id, "form_success").should be true
    element_present?(:xpath, "//*[@id='form_success']/h2/i").should be true
    verify { element_present?(:link, "OK, GOT IT").should be_true }
    @driver.find_element(:link, "OK, GOT IT").click
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
end

describe "SocrativeContactForm" do 

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.socrative.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.get(@base_url)
  end
  
  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end

  it 'tests_contact_form' do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.find_element(:link, "Contact").click
    wait.until { @driver.find_element(:xpath, "//aside[3]").displayed? }
    element_present?(:id, "help_submit").should be true
    (@driver.find_element(:xpath, "//aside[3]/div/header/h1").text).should == "Contact Us"
    @driver.find_element(:xpath, "//aside[3]/div/i").click
  end

end