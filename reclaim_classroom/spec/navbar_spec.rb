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
    @links.click(:id, "menu-item-69")
    @links.home_page?.should be true
    @links.go_back
    @links.click(:id, "menu-item-73")
    @links.about_page?.should be true
    @links.go_back
    @links.window_switch(:id, "menu-item-74", "http://www.amazon.com/Reclaiming-Classroom-Trenton-Goble/dp/1519636687/ref=sr_1_6?ie=UTF8&qid=1452796927&sr=8-6&keywords=reclaiming+the+classroom")
  end
end