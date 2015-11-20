require_relative 'spec_helper'
require_relative '../pages/slo_formb'

describe "SloFormB" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = SloB.new(@driver)
  end

  it "tests_slo_b_form" do 
    @form.info_form_present?.should be true
    @form.with('Slo TestB', '84087', 'slob@test.com', '801-548-3322')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown(:id, "school_list", "WEST BOUNTIFUL SCHOOL")
    @form.click(:id, "submit")
    @form.success_check_present?.should be true
  end

  it "tests_slo_b_notlisted_form" do 
    @form.info_form_present?.should be true
    @form.with('Notlisted TestB', '83713', 'notlistedB@test.com', '208-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown(:id, "school_list", "SCHOOL NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_list_alt").displayed? }
    @driver.find_element(:id, "school_list_alt").send_keys "Hogwarts"
    @form.click(:id, "submit")
    @form.success_check_present?.should be true
  end
end