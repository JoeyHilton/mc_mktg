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
		@buttonclick.successful_link_1
		expect(@driver.title).to eq("MasteryCon | on the move - Westbury, NY Tickets, Westbury | Eventbrite")

 		@driver.navigate.back

 		@buttonclick.successful_link_2
		expect(@driver.title).to eq("MasteryCon | on the move - West Seneca, NY Tickets, West Seneca | Eventbrite")

 		@driver.navigate.back

 		@buttonclick.successful_link_3
		expect(@driver.title).to eq("MasteryCon | on the move - Syracuse, NY Tickets, Syracuse | Eventbrite")
	end

end