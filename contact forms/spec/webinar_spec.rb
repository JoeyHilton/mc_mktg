require_relative 'spec_helper'
require_relative '../pages/webinar'

describe "request demo form" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @form = Webinar.new(@driver)
  end

  it "tests_webinar_form" do 
    @form.click(:xpath, "//*[@id='webinar_premium']/div[1]/a/span")
    @form.info_form_present?.should be true
    @form.with('Webinar',  'Test', 'Chief', '208-456-1237', Faker::Internet.email)
    @form.select_dropdown(:xpath, "//*[@id='form_area_one']/fieldset[2]/label[1]/select", "Teacher")
    @form.select_dropdown(:xpath, "//*[@id='form_area_one']/fieldset[2]/label[2]/select", "ID")
    @form.click(:xpath, "//*[@id='radio-btns']/div[1]/span/input")
    @form.click(:class, "lte_gry_rnd_btn")
    @form.success_message_present?.should be true
  end

  it "tests_recorded_webinar_form" do 
    @form.click(:xpath, ".//*[@id='webinar_recorded']/div/a/span")
    @form.correct_page?
    @form.info_form_present?.should be true
    @form.with_this('Recorded Test', 'Viceroy', '385-456-1237', Faker::Internet.email)
    @form.select_dropdown(:id, "role", "School Administrator")
    @form.select_dropdown(:id, "state", "AL")
    @form.click(:xpath, ".//*[@id='radio-btns']/div[1]/span/input")
    @form.click(:class, "lte_gry_rnd_btn")
    @form.video?
  end
end