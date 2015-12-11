require_relative 'spec_helper'
require_relative '../pages/mc_contact'

describe "mc contact form" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = McContact.new(@driver)
  end

  it "tests_contactus_form" do 
    @form.click(:link, "REQUEST MORE INFO")
    @form.info_form_present?.should be true
    @form.with('Contact','Test', 'Prince of the Land of Stench', 'contact@test.com', '801-548-3322', 'I want to know things!')
    @form.select_dropdown(:id, "organization_info", "K-12")
    @form.select_dropdown(:class, "role", "Teacher")
    @form.send('72201')
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.select_dropdown_index(:id, "signUpSchool", 2)
    @form.click(:xpath, "//*[@id='form_area_one']/button")
    @form.success_message_present?.should be true
  end

  it "tests_contactus_notlisted_form" do 
    @form.click(:link, "REQUEST MORE INFO")
    @form.info_form_present?.should be true
    @form.with('Contact','Test', 'Prince of the Land of Stench', 'contact@test.com', '801-548-3322', 'Why am I not listed?')
    @form.select_dropdown(:id, "organization_info", "K-12")
    @form.select_dropdown(:class, "role", "Teacher")
    @form.send('72201')
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.select_dropdown(:id, "signUpSchool", "School NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_list_alt").displayed? }
    @form.enter('Labyrinth')
    @form.click(:xpath, "//*[@id='form_area_one']/button")
    @form.success_message_present?.should be true
  end
end