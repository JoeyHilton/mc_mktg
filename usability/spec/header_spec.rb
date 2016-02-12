require_relative 'spec_helper'
require_relative '../pages/header'

describe "footer" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.masteryconnect.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @header = Header.new(@driver)
  end

  it "tests_header_text" do 
  	puts "Headline and subhead are displayed" if @header.wait.until {
    	@header.elements_present?.should be true
    }
  end
end