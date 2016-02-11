require_relative 'spec_helper'
require_relative '../pages/mindful'

describe "request demo form" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = Mindful.new(@driver)
  end

  fname = Faker::Name.first_name
  lname = Faker::Name.last_name
    
  it "tests_mindful_form" do 
    @form.info_form_present?.should be true
    @form.with('Mindful Test', fname + "." + lname +  "@test.com", '208-456-1237', '90001')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown_index(:id, 'school_list', 2)
    @form.click(:id, "submit")
    @form.success_message_present?.should be true
  end

  it "tests_mindful_notlisted_form" do 
    @form.info_form_present?.should be true
    @form.with('Mindfulnotlisted Test', fname + "." + lname +  "@test.com", '208-456-1237', '90001')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown(:id, 'school_list', "SCHOOL NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_manual_input").displayed? }
    @form.alt("Xaviers School for the Gifted")
    @form.click(:id, "submit")
    @form.success_message_present?.should be true
  end
end