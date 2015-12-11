require_relative 'spec_helper'
require_relative '../pages/riddle'

describe "Riddle" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = Riddle.new(@driver)
  end

  it "tests_riddle_form" do 
    @form.click(:xpath, "//*[@id='yellow']/div[1]")
    @form.info_form_present?.should be true
    @form.with('stamp','Riddle Test', '19947', 'riddle@test.com', '801-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown_index(:id, "school_list", 2)
    @form.click(:id, "submit")
    @form.success_form_present?.should be true
    @form.success_message_present?.should be true
  end

  it "tests_riddle_notlisted_form" do 
    @form.click(:xpath, "//*[@id='yellow']/div[1]")
    @form.info_form_present?.should be true
    @form.with('stamp', 'Notlisted Riddletest', '19947', 'riddlenotlisted@test.com', '208-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown(:id, "school_list", "SCHOOL NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_manual_input").displayed? }
    @driver.find_element(:id, "school_manual_input").send_keys "Clown College"
    @form.click(:id, "submit")
    @form.success_form_present?.should be true
    (@driver.find_element(:xpath, "//*[@id='riddle_right']/div[1]/h3").text).should == "Nailed it!"
  end
end