require_relative 'spec_helper'
require_relative '../pages/footer'

describe "footer" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.reclaimingtheclassroom.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @links = Footer.new(@driver)
  end

  it "tests_footer" do 
    @links.links_present?.should be true
    @links.window_switch(:class, "icon-twitter", "https://twitter.com/TrentonGoble")
    @links.window_switch(:link, "MasteryConnect", "https://www.masteryconnect.com/")
  end
end