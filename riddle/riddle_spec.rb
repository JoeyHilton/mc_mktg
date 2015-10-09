require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
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
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "Yellow test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "Teacher")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "yellow@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
    element_present?(:xpath, "//*[@id='riddle_right']/div[2]/img").should be true

    first_window = @driver.window_handle
    @driver.find_element(:link, "@MasteryConnect").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect (@MasteryConnect) | Twitter'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect (@MasteryConnect) | Twitter'
    @driver.current_url.should == "https://twitter.com/masteryconnect"
    @driver.switch_to.window(first_window)
    @driver.find_element(:xpath, "//*[@id='form_success']/div[1]").click
  end

  it "tests_form_dropdown_from_red_pencil" do 
    @driver.find_element(:xpath, "//*[@id='red']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true

    @driver.find_element(:xpath, "//*[@id='answer']").clear
    @driver.find_element(:xpath, "//*[@id='answer']").send_keys "dictionary"
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "red test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "School Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "red@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "84087"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "WEST BOUNTIFUL SCHOOL")
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
    element_present?(:xpath, "//*[@id='riddle_right']/div[2]/img").should be true

    first_window = @driver.window_handle
    @driver.find_element(:link, "@MasteryConnect").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect (@MasteryConnect) | Twitter'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect (@MasteryConnect) | Twitter'
    @driver.current_url.should == "https://twitter.com/masteryconnect"
    @driver.switch_to.window(first_window)
    @driver.find_element(:xpath, "//*[@id='form_success']/div[1]").click
  end

  it "tests_form_dropdown_from_teal_pencil" do 
    @driver.find_element(:xpath, "//*[@id='teal']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true

    @driver.find_element(:xpath, "//*[@id='answer']").clear
    @driver.find_element(:xpath, "//*[@id='answer']").send_keys "short"
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "teal test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "District Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "teal@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "83713"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "CENTENNIAL HIGH SCHOOL")
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
    element_present?(:xpath, "//*[@id='riddle_right']/div[2]/img").should be true

    first_window = @driver.window_handle
    @driver.find_element(:link, "@MasteryConnect").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect (@MasteryConnect) | Twitter'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect (@MasteryConnect) | Twitter'
    @driver.current_url.should == "https://twitter.com/masteryconnect"
    @driver.switch_to.window(first_window)
    @driver.find_element(:xpath, "//*[@id='form_success']/div[1]").click
  end

  it "tests_form_dropdown_from_black_pencil" do 
    @driver.find_element(:xpath, "//*[@id='black']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true

    @driver.find_element(:xpath, "//*[@id='answer']").clear
    @driver.find_element(:xpath, "//*[@id='answer']").send_keys "dozen"
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "black test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "District Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "black@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "83713"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "CENTENNIAL HIGH SCHOOL")
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
    element_present?(:xpath, "//*[@id='riddle_right']/div[2]/img").should be true

    first_window = @driver.window_handle
    @driver.find_element(:link, "@MasteryConnect").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect (@MasteryConnect) | Twitter'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect (@MasteryConnect) | Twitter'
    @driver.current_url.should == "https://twitter.com/masteryconnect"
    @driver.switch_to.window(first_window)
    @driver.find_element(:xpath, "//*[@id='form_success']/div[1]").click
  end

  it "tests_empty_form_fields" do 
    @driver.find_element(:xpath, "//*[@id='black']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true
    @driver.find_element(:id, "submit").click
    (@driver.find_element(:xpath, "//*[@id='form']/div[1]/span").text).should == "!"
    (@driver.find_element(:xpath, "//*[@id='form']/div[1]/div/h3").text).should == "Oops!"
    (@driver.find_element(:xpath, "//*[@id='form']/div[1]/div/p").text).should == "Please take a moment to fix the errors outlined below."
  end

  it "tests_wrong_answer" do 
    @driver.find_element(:xpath, "//*[@id='black']/div[1]").click
    element_present?(:xpath, "//*[@id='form']").should be true
    element_present?(:xpath, "//*[@id='submit']").should be true

    @driver.find_element(:xpath, "//*[@id='answer']").clear
    @driver.find_element(:xpath, "//*[@id='answer']").send_keys "shoe"
    @driver.find_element(:xpath, "//*[@id='full_name']").send_keys "black test"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "role")).select_by(:text, "District Administrator")
    @driver.find_element(:xpath, "//*[@id='email']").send_keys "black@test.com"
    @driver.find_element(:xpath, "//*[@id='phone']").send_keys "111-222-3333"
    @driver.find_element(:xpath, "//*[@id='zip_code']").send_keys "83713"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "school_list")).select_by(:text, "CENTENNIAL HIGH SCHOOL")
    @driver.find_element(:id, "submit").click
    element_present?(:xpath, "//*[@id='lean_overlay']").should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_wrong']/div[1]/h3").text).should == "Wha-wha-wha..."
    element_present?(:xpath, "//*[@id='riddle_wrong']/div[2]/img").should be true

    first_window = @driver.window_handle
    @driver.find_element(:link, "@MasteryConnect").click
    all_windows = @driver.window_handles
    new_window = all_windows.select { |this_window| this_window != first_window }

    @driver.switch_to.window(first_window)
    expect(@driver.title).not_to eql 'MasteryConnect (@MasteryConnect) | Twitter'

    @driver.switch_to.window(new_window)
    expect(@driver.title).to eql 'MasteryConnect (@MasteryConnect) | Twitter'
    @driver.current_url.should == "https://twitter.com/masteryconnect"
    @driver.switch_to.window(first_window)
    @driver.find_element(:xpath, "//*[@id='form_cancel']/div[1]").click
  end

  it "tests_masteryconnect.com_link" do 
    @driver.find_element(:xpath, "html/body/footer[1]/div/p/a").click

    expect(@driver.title).to eql 'MasteryConnect'
    @driver.current_url.should == "https://www.masteryconnect.com/"
    @driver.navigate.back
  end

  it "tests_contest_rules_regs" do 
    @driver.find_element(:xpath, "//*[@id='tc_content']").displayed?.should == false
    @driver.find_element(:xpath, "//*[@id='show_tc']").click
    @driver.find_element(:xpath, "//*[@id='tc_content']").displayed?.should == true
    (@driver.find_element(:xpath, "//*[@id='tc_content']/h4").text).should == "MasteryConnect
Official Sweepstakes Rules and Regulations"
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def element_displayed?(how, what)
    @driver.manage.timeouts.implicit_wait = 0
        result = @driver.find_elements(how, what).size() > 0
        if result
            result = @driver.find_element(how, what).displayed?
        end
        @driver.manage.timeouts.implicit_wait = 30
        return result
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