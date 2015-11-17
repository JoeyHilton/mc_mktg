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
    @base_url = "https://www.masteryconnect.com/"
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

    @driver.find_element(:id, "form_success").displayed?
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
    @driver.find_element(:id, "submit").submit

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

describe "MCcomForms" do 

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.masteryconnect.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  after(:each) do
    @driver.quit
    # @verification_errors.should == []
  end
  
  it "tests_contactus_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/contact_us.html")
    @driver.find_element(:link, "REQUEST MORE INFO").click
    @driver.find_element(:name, "first_name").send_keys "Contact"
    @driver.find_element(:name, "last_name").send_keys "Test"
    @driver.find_element(:name, "title").send_keys "Prince of the Land of Stench"
    select_dropdown(:class, "role", "Teacher")
    @driver.find_element(:name, "phone").send_keys "801-987-6543"
    @driver.find_element(:name, "email").send_keys "contact@test.com"
    select_dropdown(:id, "organization_info", "K-12")
    @driver.find_element(:id, "zip").send_keys "83713"
    wait.until { @driver.find_element(:id, "signUpSchool").displayed? }
    # @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").click
    # @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").click
    select_dropdown(:id, "signUpSchool", "CENTENNIAL HIGH SCHOOL")
    @driver.find_element(:xpath, "//*[@id='form_area_one']/button").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_contactus_notlisted_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/contact_us.html")
    @driver.find_element(:link, "REQUEST MORE INFO").click
    @driver.find_element(:name, "first_name").send_keys "Contactnotlisted"
    @driver.find_element(:name, "last_name").send_keys "Test"
    @driver.find_element(:name, "title").send_keys "Goblin King"
    select_dropdown(:class, "role", "Teacher")
    @driver.find_element(:name, "phone").send_keys "801-987-6543"
    @driver.find_element(:name, "email").send_keys "contact@test.com"
    select_dropdown(:id, "organization_info", "K-12")
    @driver.find_element(:id, "zip").send_keys "83713"
    wait.until { @driver.find_element(:id, "signUpSchool").displayed? }
    # @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").click
    # @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").click
    select_dropdown(:id, "signUpSchool", "School NOT LISTED")
    wait.until { @driver.find_element(:id, "school_list_alt").displayed? }
    @driver.find_element(:id, "school_list_alt").send_keys "Labyrinth"
    @driver.find_element(:xpath, "//*[@id='form_area_one']/button").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_joinforfree_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/pricing.html")
    @driver.find_element(:id, "free_top_button").click
    (@driver.find_element(:xpath, "//*[@id='pricing']/aside/div/div/header/h1").text).should == "Sign Up for a Free Account"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "teacher_title")).select_by(:text, "Mr.")
    @driver.find_element(:id, "teacher_first_name").send_keys "Joinforfree"
    @driver.find_element(:id, "teacher_last_name").send_keys "Test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "contact_role")).select_by(:text, "Teacher")
    @driver.find_element(:id, "teacher_email").send_keys Faker::Internet.email
    @driver.find_element(:id, "zip").send_keys "83713"
    wait.until { @driver.find_element(:id, "signUpSchool").displayed? }
    @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").click
    # Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "signUpSchool")).select_by(:text, "JOPLIN ELEMENTARY SCHOOL")
    @driver.find_element(:name, "subjects[]").click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "teacher_hear_about_us")).select_by(:text, "Blog Post")
    @driver.find_element(:id, "contact").click
    wait.until { @driver.find_element(:id, "contact_title").displayed? }
    @driver.find_element(:id, "contact_title").send_keys "Poobah"
    @driver.find_element(:id, "teacher_phone").send_keys "801-888-1122"
    # binding.pry
    @driver.find_element(:class, "lrg_orn_button").click
    ((@driver.find_element(:xpath, "//*[@id='dialog']/div/div/h2").text).should == "Thank you for signing up!" || (@driver.current_url).should == "https://app.masteryconnect.com/setup/step1")
  end

  it "tests_requestdemo_school_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)

    @driver.get(@base_url + "/request-a-demo.html")
    select_dropdown(:id, "organization_info", "I work at a school")
    @driver.find_element(:id, "zip").send_keys "83713"
    wait.until { @driver.find_element(:id, "signUpSchool").displayed? }
    @driver.find_element(:name, "first_name").send_keys "Requestdemo"
    @driver.find_element(:name, "last_name").send_keys "Test"
    @driver.find_element(:name, "title").send_keys "Caesar"
    select_dropdown(:class, "role", "Teacher")
    @driver.find_element(:name, "phone").send_keys "208-456-1237"
    @driver.find_element(:name, "email").send_keys Faker::Internet.email
    # Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "organization_info")).select_by(:text, "I work at a school")
    # random = [0, 1, 2, 3].sample
    # choice = random.to_s
    # Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "organization_info")).select_by(:value, choice)

    # if Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "organization_info")).select_by(:text, "I work at a school")
    #   @driver.find_element(:id, "zip").send_keys "83713"
    #   wait.until { @driver.find_element(:id, "signUpSchool").displayed? }
    #   @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").click
    #   # Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "signUpSchool")).select_by(:text, "JOPLIN ELEMENTARY SCHOOL")
    # else
    #   puts "The choice was #{choice}"
    # end

    # wait_for(10) { @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[1]").displayed? }
    # Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "signUpSchool")).select_by(:text, "JOPLIN ELEMENTARY SCHOOL")
    select_dropdown(:id, "signUpSchool", "CENTENNIAL HIGH SCHOOL")

    # This is still not sending to salesforce, even though the spec passes. Grrrrrr!
    # @driver.find_element(:id, "signUpSchool").send_keys "CENTENNIAL HIGH SCHOOL"
    # @driver.find_element(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[3]").click

    @driver.find_element(:class, "med_gry_rnd_btn").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_requestdemo_schoolnotlisted_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)

    @driver.get(@base_url + "/request-a-demo.html")
    select_dropdown(:id, "organization_info", "I work at a school")
    @driver.find_element(:id, "zip").send_keys "83713"
    wait.until { @driver.find_element(:id, "signUpSchool").displayed? }
    @driver.find_element(:name, "first_name").send_keys "Requestdemo"
    @driver.find_element(:name, "last_name").send_keys "Test"
    @driver.find_element(:name, "title").send_keys "Caesar"
    select_dropdown(:class, "role", "Teacher")
    @driver.find_element(:name, "phone").send_keys "208-456-1237"
    @driver.find_element(:name, "email").send_keys Faker::Internet.email
    select_dropdown(:id, "signUpSchool", "School NOT LISTED")
    @driver.find_element(:id, "school_list_alt").send_keys "Battle School"
    @driver.find_element(:class, "med_gry_rnd_btn").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_requestdemo_district_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/request-a-demo.html")
    @driver.find_element(:name, "first_name").send_keys "Districttest"
    @driver.find_element(:name, "last_name").send_keys "Requestdemo"
    @driver.find_element(:name, "title").send_keys "Colonel"
    select_dropdown(:class, "role", "District Administrator")
    @driver.find_element(:name, "phone").send_keys "208-456-1237"
    @driver.find_element(:name, "email").send_keys Faker::Internet.email
    select_dropdown(:id, "organization_info","I work at a district")
    wait.until { @driver.find_element(:id, "zip").displayed? }
    @driver.find_element(:id, "zip").send_keys "83713"
    select_dropdown(:id, "signUpSchool","MERIDIAN JOINT DISTRICT")
    @driver.find_element(:class, "med_gry_rnd_btn").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_requestdemo_districtnotlisted_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/request-a-demo.html")
    @driver.find_element(:name, "first_name").send_keys "Districtnolistytest"
    @driver.find_element(:name, "last_name").send_keys "Requestdemo"
    @driver.find_element(:name, "title").send_keys "Colonel"
    select_dropdown(:class, "role", "District Administrator")
    @driver.find_element(:name, "phone").send_keys "208-456-1237"
    @driver.find_element(:name, "email").send_keys Faker::Internet.email
    select_dropdown(:id, "organization_info","I work at a district")
    wait.until { @driver.find_element(:id, "zip").displayed? }
    @driver.find_element(:id, "zip").send_keys "83713"
    select_dropdown(:id, "signUpSchool","District NOT LISTED")
    wait.until { @driver.find_element(:id, "school_list_alt").displayed? }
    @driver.find_element(:id, "school_list_alt").send_keys "District Nine"
    @driver.find_element(:class, "med_gry_rnd_btn").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_requestdemo_Notdistrict_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/request-a-demo.html")
    @driver.find_element(:name, "first_name").send_keys "Noparttest"
    @driver.find_element(:name, "last_name").send_keys "Requestdemo"
    @driver.find_element(:name, "title").send_keys "Friar"
    select_dropdown(:class, "role", "Other")
    @driver.find_element(:name, "phone").send_keys "208-456-1237"
    @driver.find_element(:name, "email").send_keys Faker::Internet.email
    select_dropdown(:id, "organization_info", "I'm not part of a school/district")
    @driver.find_element(:id, "manualOrg").send_keys "Knights of Ren"
    select_dropdown(:name, "manual-state", "AK")
    @driver.find_element(:class, "med_gry_rnd_btn").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_requestdemo_outsideUS_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/request-a-demo.html")
    @driver.find_element(:name, "first_name").send_keys "OutsideUStest"
    @driver.find_element(:name, "last_name").send_keys "Requestdemo"
    @driver.find_element(:name, "title").send_keys "Captain"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:class, "role")).select_by(:text, "Other")
    @driver.find_element(:name, "phone").send_keys "208-456-1237"
    @driver.find_element(:name, "email").send_keys Faker::Internet.email
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "organization_info")).select_by(:text, "I work in a school/district outside of the U.S.")
    @driver.find_element(:xpath, "//*[@id='manual-school-entry-school']/input").send_keys "HMS Prep Academy"
    @driver.find_element(:xpath, "//*[@id='manual-school-entry-district']/input").send_keys "Greater London"
    @driver.find_element(:xpath, "//*[@id='manual-school-entry-country']/input").send_keys "England"
    @driver.find_element(:class, "med_gry_rnd_btn").click
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
  end

  it "tests_webinar_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/webinars.html")
    @driver.find_element(:xpath, "//*[@id='webinar_matters']/div[1]/a/span").click
    @driver.find_element(:name, "Name_First").send_keys "Webinar"
    @driver.find_element(:name, "Name_Last").send_keys "Test"
    @driver.find_element(:name, "JobTitle").send_keys "Chief"
    @driver.find_element(:name, "Phone").send_keys "208-456-1237"
    @driver.find_element(:name, "Email").send_keys Faker::Internet.email
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='form_area_one']/fieldset[2]/label[1]/span/select")).select_by(:text, "Teacher")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='form_area_one']/fieldset[2]/label[2]/span/select")).select_by(:text, "ID")
    @driver.find_element(:xpath, "//*[@id='radio-btns']/div[1]/span/input").click
    @driver.find_element(:class, "lte_gry_rnd_btn").click
    wait.until { @driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").displayed? }
    (@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thank you for registering for our Webinar!"
  end

  it "tests_mindful_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/mindful.html")
    @driver.find_element(:id, "full_name").send_keys "Mindful Test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:id, "email").send_keys Faker::Internet.email
    @driver.find_element(:id, "zip_code").send_keys "83713"
    @driver.find_element(:id, "phone").send_keys "208-456-1237"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SUMMERWIND ELEMENTARY SCHOOL")
    @driver.find_element(:id, "submit").click
    (@driver.find_element(:xpath, "//*[@id='form_success']/h2").text).should == "Thanks!"
  end

  it "tests_notlisted_mindful_form" do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    @driver.get(@base_url + "/mindful.html")
    @driver.find_element(:id, "full_name").send_keys "Notlistedmindful Test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:id, "email").send_keys Faker::Internet.email
    @driver.find_element(:id, "zip_code").send_keys "83713"
    @driver.find_element(:id, "phone").send_keys "208-456-1237"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "SCHOOL NOT LISTED")
    wait.until { @driver.find_element(:id, "school_manual_input").displayed? }
    @driver.find_element(:id, "school_manual_input").send_keys "Xaviers School for the Gifted"
    @driver.find_element(:id, "submit").click
    (@driver.find_element(:xpath, "//*[@id='form_success']/h2").text).should == "Thanks!"
  end

  def select_dropdown(selector, tag, option)
    dropdown = @driver.find_element(selector, tag)
    # sleep 5
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, option)
  end

end

describe "SocrativeForms" do 

  before(:each) do
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.cache.disk.enable'] = false
    profile['browser.cache.memory.enable'] = false
    profile['browser.cache.offline.enable'] = false
    profile['network.http.use-cache'] = false
    @driver = Selenium::WebDriver.for :firefox, :profile => profile
    @driver.get("http://www.socrative.com")
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = [] 
  end
  
  after(:each) do
    @driver.quit
  end

  it 'tests_contact_form' do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.find_element(:link, "Contact").click
    wait.until { @driver.find_element(:xpath, "//aside[3]").displayed? }
    element_present?(:id, "help_submit").should be true
    (@driver.find_element(:xpath, "//aside[3]/div/header/h1").text).should == "Contact Us"
    @driver.find_element(:name, "user_email").send_keys "socrative@test.com"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "select_device")).select_by(:text, "Firefox - Browser")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "select_topic")).select_by(:text, "Feedback")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "select_area")).select_by(:text, "Space Race")
    @driver.find_element(:name, "user_description").send_keys "You guys are outta this world!"
    @driver.find_element(:id, "help_submit").click
    element_present?(:link, "<< Go back home").should be true
  end

  it 'tests_socrative_k-12_signup' do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.find_element(:link, "GET A FREE ACCOUNT").click
    (@driver.current_url).should == "https://b.socrative.com/login/teacher/#register-teacher"
    @driver.find_element(:id, "first-name").send_keys "Newteacher"
    @driver.find_element(:id, "last-name").send_keys "Test"
    @driver.find_element(:id, "profile-email").send_keys Faker::Internet.email
    @driver.find_element(:id, "profile-email").send_keys :command, 'a'
    @driver.find_element(:id, "profile-email").send_keys :command, 'c'
    @driver.find_element(:id, "confirm-email").send_keys :command, 'v'
    @driver.find_element(:id, "password").send_keys "password"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='teacher-form']/div[5]/div[1]/div[2]/div/select")).select_by(:text, "USA")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "organization-type")).select_by(:text, "K-12")
    @driver.find_element(:id, "zip-code").send_keys "84087"
    wait.until { @driver.find_element(:id, "select-school").displayed? }
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "select-school")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='teacher-form']/div[7]/div/div/select")).select_by(:text, "Teacher")
    @driver.find_element(:id, "demo-yes").click
    @driver.find_element(:id, "terms").click
    @driver.find_element(:xpath, "//*[@id='teacher-form']/div[10]/div[1]/button").click
    (@driver.find_element(:id, "success-message-pop-up-message").text).should == "Welcome to Socrative!\n\nCheck out our User Guide\nto find out all the cool things you can do."
  end

  it 'tests_socrative_k-12_notlisted_signup' do 
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.find_element(:link, "GET A FREE ACCOUNT").click
    (@driver.current_url).should == "https://b.socrative.com/login/teacher/#register-teacher"
    @driver.find_element(:id, "first-name").send_keys "Newteachernotlisted"
    @driver.find_element(:id, "last-name").send_keys "Test"
    @driver.find_element(:id, "profile-email").send_keys Faker::Internet.email
    @driver.find_element(:id, "profile-email").send_keys :command, 'a'
    @driver.find_element(:id, "profile-email").send_keys :command, 'c'
    @driver.find_element(:id, "confirm-email").send_keys :command, 'v'
    @driver.find_element(:id, "password").send_keys "password"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='teacher-form']/div[5]/div[1]/div[2]/div/select")).select_by(:text, "USA")
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "organization-type")).select_by(:text, "K-12")
    @driver.find_element(:id, "zip-code").send_keys "84087"
    wait.until { @driver.find_element(:id, "select-school").displayed? }
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "select-school")).select_by(:text, "SCHOOL NOT LISTED")
    wait.until { @driver.find_element(:xpath, "//*[@id='teacher-form']/div[6]/div[4]/div/select").displayed? }
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='teacher-form']/div[6]/div[4]/div/select")).select_by(:text, "Utah")
    @driver.find_element(:id, "school-name").send_keys "Lazy Town School"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:xpath, "//*[@id='teacher-form']/div[7]/div/div/select")).select_by(:text, "Teacher")
    @driver.find_element(:id, "demo-yes").click
    @driver.find_element(:id, "terms").click
    @driver.find_element(:xpath, "//*[@id='teacher-form']/div[10]/div[1]/button").click
    (@driver.find_element(:id, "success-message-pop-up-message").text).should == "Welcome to Socrative!\n\nCheck out our User Guide\nto find out all the cool things you can do."
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

end