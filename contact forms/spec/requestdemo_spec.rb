require_relative 'spec_helper'
require_relative '../pages/requestdemo'

describe "request demo form" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = RequestDemo.new(@driver)
  end

  it "tests_requestdemo_school_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.info_form_present?.should be true
    @form.with('Requestdemo','Test', 'Caesar', '208-456-1237',  fname + "." + lname +  "@test.com", '06443')
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.select_dropdown(:class, "role", "Teacher")
    # @form.click(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[3]")
    @form.select_dropdown(:id, "organization_info", "I work at a school")
    @form.select_dropdown_index(:id, "signUpSchool", 2)
    @form.click(:class, "med_gry_rnd_btn")
    @form.success_message_present?.should be true
  end

  it "tests_requestdemo_schoolnotlisted_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.info_form_present?.should be true
    @form.with('Requestnotlisted','Test', 'King', '208-456-1237',  fname + "." + lname +  "@test.com", '06443')
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.select_dropdown(:class, "role", "Teacher")
    @form.select_dropdown(:id, "organization_info", "I work at a school")
    @form.select_dropdown(:id, "signUpSchool", "School NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_list_alt").displayed? }
    @form.alt("Battle School")
    @form.click(:class, "med_gry_rnd_btn")
    @form.success_message_present?.should be true
  end

  it "tests_requestdemo_district_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.info_form_present?.should be true
    @form.select_dropdown(:id, "organization_info", "I work at a district")
    @form.with('Districttest','Requestdemo', 'Colonel', '208-456-1237',  fname + "." + lname +  "@test.com", '06443')
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.select_dropdown(:class, "role", "Teacher")
    @form.select_dropdown_index(:id, "signUpSchool", 2)
    @form.click(:class, "med_gry_rnd_btn")
    @form.success_message_present?.should be true
  end

  it "tests_requestdemo_districtnotlisted_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.info_form_present?.should be true
    @form.select_dropdown(:id, "organization_info", "I work at a district")
    @form.with('Districtnolistytest','Requestdemo', 'Chief', '208-456-1237',  fname + "." + lname +  "@test.com", '06443')
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.select_dropdown(:class, "role", "Teacher")
    @form.select_dropdown(:id, "signUpSchool", "District NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_list_alt").displayed? }
    @form.alt("District Nine")
    @form.click(:class, "med_gry_rnd_btn")
    @form.success_message_present?.should be true
  end

  it "tests_requestdemo_nopart_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.info_form_present?.should be true
    @form.select_dropdown(:id, "organization_info", "I'm not part of a school/district")
    @form.nopart('Noparttest','Requestdemo', 'Friar', '208-456-1237',  fname + "." + lname +  "@test.com")
    @form.select_dropdown(:class, "role", "Other")
    @form.wait_for(10) { @driver.find_element(:id, "manualOrg").displayed? }
    @form.org("Knights of Ren")
    @form.select_dropdown(:name, "manual-state", "CT")
    @form.click(:class, "med_gry_rnd_btn")
    @form.success_message_present?.should be true
  end

  it "tests_requestdemo_outsideUS_form" do 
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    @form.info_form_present?.should be true
    @form.select_dropdown(:id, "organization_info", "I work in a school/district outside of the U.S.")
    @form.nopart('OutsideUStest','Requestdemo', 'Captain', '208-456-1237',  fname + "." + lname +  "@test.com")
    @form.select_dropdown(:class, "role", "Other")
    @form.wait_for(10) { @driver.find_element(:id, "notUSSchool").displayed? }
    @form.outside_us("HMS Prep Academy", "Greater London", "England")
    @form.click(:class, "med_gry_rnd_btn")
    @form.success_message_present?.should be true
  end
end