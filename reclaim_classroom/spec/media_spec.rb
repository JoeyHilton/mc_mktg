require_relative 'spec_helper'
require_relative '../pages/media'

describe "media_page" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.reclaimingtheclassroom.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @media = Media.new(@driver)
  end

  it "tests_media_page_elements" do 
    @media.elements_present?.should be true
    @media.click(:link, "Trenton Goble")
    @media.about_page?
    @media.go_back
  end

  it "tests_external_links" do 
    @media.external_articles?
  end
end