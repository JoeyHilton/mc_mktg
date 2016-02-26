require_relative 'spec_helper'
require_relative '../pages/footer'

describe "footer" do

  before(:each) do
    ENV['base_url'] ||= 'http://www.masterycon.com/'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @links = Footer.new(@driver)
  end

  it "tests_footer" do 
    @links.elements_present?
  end
end