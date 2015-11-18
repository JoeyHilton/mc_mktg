require_relative 'spec_helper'
require_relative '../pages/slo_forma'

describe "SloFormA" do

  before(:each) do
    ENV['base_url'] = 'https://www.masteryconnect.com'
    @driver.manage.timeouts.implicit_wait = 30
    @form = SloA.new(@driver)
  end

  it "tests_slo_a_form" do 
    @form.click(:link, "GET MORE INFO")
    @form.info_form_present?.should be true
    @form.with('Slo', 'TestA', '84087', 'sloa@test.com', '801-548-3322')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown(:id, "school_list", "WEST BOUNTIFUL SCHOOL")
    @form.click(:id, "submit")
    @form.success_modal_present?.should be true
    @form.click(:css, "#form_success > div.modal_close")
  end

  it "tests_slo_a_notlisted_form" do 
    @form.click(:class, "more_info")
    @form.info_form_present?.should be true
    @form.with('Notlisted', 'TestA', '83713', 'notlisted@test.com', '208-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown(:id, "school_list", "SCHOOL NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_list_alt").displayed? }
    @driver.find_element(:id, "school_list_alt").send_keys "Starfleet Academy"
    @form.click(:id, "submit")
    @form.success_modal_present?.should be true
    @form.click(:css, "#form_success > div.modal_close")
  end
end