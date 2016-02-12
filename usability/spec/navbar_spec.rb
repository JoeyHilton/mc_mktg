require_relative 'spec_helper'
require_relative '../pages/navbar'

describe "navbar" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @links = Navbar.new(@driver)
  end

  it "verifies_elements" do 
    @links.links_present?
  end

  it "tests_links" do
    @links.click(:class, "logo")
    @links.mc_page?
    @links.go_back
    @links.click(:link, "DEMO")
    @links.demo_page?
    @links.go_back
    @links.click(:link, "LOGIN")
    @links.login_page?
  end
end