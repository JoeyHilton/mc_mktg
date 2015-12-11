require_relative 'spec_helper'
require_relative '../pages/joinforfree'

describe "join for free form" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = JoinForFree.new(@driver)
  end

  it "tests_joinforfree_form" do 
    @form.click(:id, "free_top_button")
    @form.info_form_present?.should be true
    @form.select_dropdown(:id, "teacher_title", "Mr.")
    @form.with('Joinforfree','Test', Faker::Internet.email, "85040")
    @form.select_dropdown(:id, "contact_role", "Teacher")
    @form.wait_for(10) { @driver.find_element(:id, "signUpSchool").displayed? }
    @form.click(:xpath, "//*[@id='signUpSchool']/optgroup[1]/option[3]")
    @form.click(:name, "subjects[]")
    @form.select_dropdown(:id, "teacher_hear_about_us", "Blog Post")
    @form.click(:id, "contact")
    @form.enter("Poobah", "801-654-3321")
    @form.click(:class, "lrg_orn_button")
    @form.success_message_present?.should be true
  end
end