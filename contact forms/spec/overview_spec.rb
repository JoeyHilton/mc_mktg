require_relative 'spec_helper'
require_relative '../pages/overview'

describe "Overview" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = Overview.new(@driver)
  end

  it "tests_slo_b_form" do 
    @form.click(:xpath, "//li[5]/span")
    @form.with('Overview Test', '84087', 'overview@test.com', '801-548-3322')
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown(:id, "school_list", "WEST BOUNTIFUL SCHOOL")
    @form.click(:id, "submit")
    @form.success_form_present?.should be true
  end

  it "tests_slo_b_notlisted_form" do 
    @form.click(:xpath, "//li[5]/span")
    @form.with('Notlisted overviewtest', '83713', 'notlistedoverview@test.com', '208-548-3322')
    @form.select_dropdown(:id, "role", "Teacher")
    @form.select_dropdown(:id, "school_list", "SCHOOL NOT LISTED")
    @form.wait_for(10) { @driver.find_element(:id, "school_manual_input").displayed? }
    @driver.find_element(:id, "school_manual_input").send_keys "Imperial Academy"
    @form.click(:id, "submit")
    @form.success_form_present?.should be true
  end
end