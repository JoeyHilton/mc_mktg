require_relative 'spec_helper'
require_relative '../pages/home'

describe "home_page" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @home = Home.new(@driver)
  end

  it "tests_presence_of_elements" do 
    puts "subnav elements found and verified" if @home.wait.until {
      @home.elements_present?.should be true
    }
  end

  # it "tests_links_on_page" do
  #   @home.click(:class, "circle")
  #   @home.media_page?
  #   @home.go_back
  #   @home.click(:link, "READ BIO")
  #   @home.about_page?
  #   @home.go_back
  # end
end