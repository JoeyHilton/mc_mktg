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
    puts "Test Passed: Media Page elements found and verified" if @media.wait.until {
      @media.elements_present?.should be true
    }
    @media.click(:link, "Trenton Goble")
    @media.about_page?
    @media.go_back
  end

  it "lists all external links" do
    puts "These are the links to be tested next:"
    @media.links_list?
  end

  it "tests_external_links" do 
    puts "Test Passed: External links validated" if @media.wait.until {
      @media.external_articles?
    } 
  end

  it "checks_available_episodes" do 
    puts "These are the available episodes ^^ " if @media.wait.until {
    @media.get_episodes_available?
  }
  end

  it "plays episode audio" do
    @media.audio_play? 
  end

  it "lists download links" do
    puts "Download links are:"
    @media.list_download_links?
  end

  it "tests subscribe links" do 
    @media.subscribe?
  end
end