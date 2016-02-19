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
    puts "subnav elements found and verified".green if @home.wait.until {
      @home.elements_present?.should be true
    }
  end

  it "tests_signup_button" do
    @home.signup_button?
    @home.click(:class, "button")
    @home.signup_page?
    @home.go_back
  end

  it "verifies_what_section" do
    @home.click(:class, "what")
    puts "'what' section headers displayed and verified".green if @home.wait.until {
      @home.what_section?
    }
  end

  it "verifies_how_section" do
    @home.click(:class, "how")
    puts "'how' section headers displayed and verified".green if @home.wait.until {
      @home.how_section?.should be true
    }
  end

  it "verifies_faq_section" do
    @home.click(:class, "faq")
    puts "'faq' section headers displayed and verified".green if @home.wait.until {
      @home.faq_section?
    }
    puts "'faq' section sub-headers displayed and verified".green if @home.wait.until {
      @home.faq_subheads?
    }
  end

  it "tests_unsubscribe_link" do
    @home.click(:class, "faq")
    @home.click(:link, "Unsubscribe")
    @home.unsub_page?
    @home.go_back
  end
end