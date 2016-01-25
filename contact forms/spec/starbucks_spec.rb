require_relative 'spec_helper'
require_relative '../pages/starbucks'

describe "FreeCoffee" do

  before(:each) do
    ENV['base_url'] = 'https://www.masteryconnect.com'
    @driver.manage.timeouts.implicit_wait = 30
    @form = Starbucks.new(@driver)
  end

  it "tests_coffee_request_form" do 
    @form.click(:class, "more_info")
    @form.info_form_present?.should be true
    @form.with('Coffee Test', '30307', 'coffee@test.com', '801-548-3322')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown_index(:id, "school_list", 2)
    @form.click(:id, "submit")
    @form.success_button_present?.should be true
    @form.click(:link, "OK, GOT IT")
  end

  it "tests_honeypot_field" do 
    @form.click(:class, "more_info")
    @form.info_form_present?.should be true
    @form.with('Honey Test', '30307', 'honey@test.com', '801-548-3322')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown_index(:id, "school_list", 2)
    @driver.execute_script("return document.getElementById('user_email').value = 'fly in the honey';")
    @form.click(:id, "submit")
    @form.success_button_present?.should be true
    @form.click(:link, "OK, GOT IT")
  end

  it "tests_coffee_notlisted_form" do 
    @form.click(:class, "more_info")
    @form.info_form_present?.should be true
    @form.with('Nobeans Test', '30307', 'nobeans@test.com', '208-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown(:id, "school_list", "School Not Listed")
    @form.wait_for(10) { @driver.find_element(:id, "school_list_alt").displayed? }
    @driver.find_element(:id, "school_list_alt").send_keys "St. Brutus"
    @form.click(:id, "submit")
    @form.success_button_present?.should be true
    @form.click(:link, "OK, GOT IT")
  end
end