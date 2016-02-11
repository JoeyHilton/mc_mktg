require_relative 'spec_helper'
require_relative '../pages/navbar'

describe "navbar" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @links = Navbar.new(@driver)
  end

  it "tests_navbar" do 
    @links.links_present?
    @links.nav_links?
  end
end