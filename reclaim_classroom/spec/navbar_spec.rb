require_relative 'spec_helper'
require_relative '../pages/navbar'

describe "navbar" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.reclaimingtheclassroom.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @links = Navbar.new(@driver)
  end

  it "tests_navbar" do 
    @links.links_present?.should be true
    @links.click(:id, "menu-item-70")
    @links.media_page?.should be true
  end
end