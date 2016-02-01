require_relative 'spec_helper'
require_relative '../pages/socrative_contact'

describe "socrative contact form" do

  before(:each) do
    ENV['base_url'] ||= 'http://www.socrative.com/'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = SocrativeContact.new(@driver)
  end

  it "tests_socrative_contact_form" do 
    @form.click(:link, "Contact")
    @form.with('socrativecontact@test.com', 'You guys rock!')
    @form.select_dropdown(:id, "select_device", "Firefox - Browser")
    @form.select_dropdown(:id, 'select_topic', "Feedback")
    @form.select_dropdown(:id, 'select_area', "Space Race")
    @form.select_dropdown(:id, "select_device", "Firefox - Browser")
    @form.click(:id, "help_submit")
    @form.click(:id, "help_submit")
    @form.success_message_present?.should be true
  end

end