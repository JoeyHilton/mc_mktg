require_relative 'spec_helper'
require_relative '../pages/socrative_signup'

describe "socrative signup form" do

  before(:each) do
    ENV['base_url'] ||= 'www.socrative.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = SocrativeSignup.new(@driver)
  end

  it "tests_signup_form" do 
    @form.click(:link, "GET A FREE ACCOUNT")
    @form.correct_url?.should be true
    @form.info_form_present?.should be true
    @form.with('Newteacher', 'Test', Faker::Internet.email)
    @driver.find_element(:id, "profile-email").send_keys :command, 'a'
    @driver.find_element(:id, "profile-email").send_keys :command, 'c'
    @driver.find_element(:id, "confirm-email").send_keys :command, 'v'
    @form.password('password')
    @form.select_dropdown(:xpath, "//*[@id='teacher-form']/div[5]/div[1]/div[2]/div/select", "USA")
    @form.select_dropdown(:id, "organization-type", "K-12")
    @form.zip('32578')
    @form.wait_for(10) { @driver.find_element(:id, "select-school").displayed? }
    @form.select_dropdown_index(:id, "select-school", 2)
    @form.select_dropdown(:xpath, "//*[@id='teacher-form']/div[7]/div/div/select", "Teacher")
    @form.click(:id, 'demo-yes')
    @form.click(:id, 'terms')
    @form.click(:xpath, "//*[@id='teacher-form']/div[10]/div[1]/button")
    @form.success_message_present?.should be true
  end

  it "tests_signup_notlisted_form" do 
    @form.click(:link, "GET A FREE ACCOUNT")
    @form.correct_url?.should be true
    @form.info_form_present?.should be true
    @form.with('Newteachernotlisted', 'Test', Faker::Internet.email)
    @driver.find_element(:id, "profile-email").send_keys :command, 'a'
    @driver.find_element(:id, "profile-email").send_keys :command, 'c'
    @driver.find_element(:id, "confirm-email").send_keys :command, 'v'
    @form.password('password')
    @form.select_dropdown(:xpath, "//*[@id='teacher-form']/div[5]/div[1]/div[2]/div/select", "USA")
    @form.select_dropdown(:id, "organization-type", "K-12")
    @form.zip('32578')
    @form.wait_for(10) { @driver.find_element(:id, "select-school").displayed? }
    @form.select_dropdown(:id, "select-school", "SCHOOL NOT LISTED")
    @form.select_dropdown(:xpath, "//*[@id='teacher-form']/div[6]/div[4]/div/select", "Florida")
    @form.alt('Lazy Town School')
    @form.select_dropdown(:xpath, "//*[@id='teacher-form']/div[7]/div/div/select", "Teacher")
    @form.click(:id, 'demo-yes')
    @form.click(:id, 'terms')
    @form.click(:xpath, "//*[@id='teacher-form']/div[10]/div[1]/button")
    @form.success_message_present?.should be true
  end

end