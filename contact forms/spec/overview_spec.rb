require_relative 'spec_helper'
require_relative '../pages/overview'

describe "Overview" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = Overview.new(@driver)
  end

  it "tests_overview_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.click(:xpath, "//li[5]/span")
    @form.with('Overview Test', '80012', fname + "." + lname +  "@test.com", '801-548-3322')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown_index(:id, "school_list", 2)
    @form.click(:id, "submit")
    @form.success_form_present?.should be true
  end

  it "tests_overview_notlisted_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.click(:xpath, "//li[5]/span")
    @form.with('Notlisted overviewtest', '80012', fname + "." + lname +  "@test.com", '208-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown(:id, "school_list", "SCHOOL NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_manual_input").displayed? }
    @driver.find_element(:id, "school_manual_input").send_keys "Imperial Academy"
    @form.click(:id, "submit")
    @form.success_form_present?.should be true
  end
end