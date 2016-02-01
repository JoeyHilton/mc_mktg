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
    @links.links_present?
    @links.click(:id, "menu-item-70")
    @links.media_page?
    @links.click(:id, "menu-item-69")
    @links.home_page?
    @links.go_back
    @links.click(:id, "menu-item-73")
    @links.about_page?
    @links.go_back
    @links.buy_link?
  end
end