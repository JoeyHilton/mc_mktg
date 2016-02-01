require_relative 'spec_helper'
require_relative '../pages/about'

describe "about_page" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.reclaimingtheclassroom.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @about = About.new(@driver)
  end

  it "tests_about_page" do 
    @about.elements_present?.should be true
    @about.find_trenton
    @about.window_switch(:link, "MasteryConnect", "https://www.masteryconnect.com/")
  end
end