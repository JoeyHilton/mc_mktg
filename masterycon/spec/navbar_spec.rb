require_relative 'spec_helper'
require_relative '../pages/navbar'

describe "navbar" do

  before(:each) do
    ENV['base_url'] ||= 'http://www.masterycon.com/'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @links = Navbar.new(@driver)
  end

  it "verifies_elements" do 
    @links.click(:id, "show_nav")
    sleep 2
    @links.links_present?
  end

  it "tests_links" do
    @links.click(:id, "show_nav")
    sleep 1
    @links.click(:link, "Call for Speakers")
    @links.speaker_page?
    @links.click(:id, "show_nav")
    sleep 1
    @links.click(:link, "Why Attend")
    @links.attend_page?
    @links.click(:id, "show_nav")
    sleep 1
    @links.click(:link, "Lodging")
    @links.lodging_page?
    @links.click(:id, "show_nav")
    @driver.manage.window.maximize
    sleep 1
    @links.click(:link, "Register")
    @links.register_page?
    @links.go_back
    @links.click(:id, "show_nav")
    @links.click(:id, "hide_nav")
    @links.not_present?
  end
end