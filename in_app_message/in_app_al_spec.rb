require 'selenium-webdriver'
require_relative 'buttonclick'
include RSpec::Expectations

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe 'ButtonClick' do

	before(:each) do
		@driver = Selenium::WebDriver.for :firefox
		ENV['base_url'] = 'https://www.masteryconnect.com'
		@buttonclick = ButtonClick.new(@driver)
	end

	after(:each) do
		@driver.quit
	end

	it 'succeeded' do
		# @driver.find_element(class: 'button').click
		@buttonclick.successful_link
		expect(@driver.title).to eq("MasteryCon | on the move - Cincinnati OH Tickets, Cincinnati
 | Eventbrite")
	end

end