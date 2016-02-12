require_relative 'base_page'

class Header < BasePage

		HEADER = { xpath: "html/body/header" }
		HEAD = { xpath: "//div[@class='container']//h1" }
		SUBHEAD = { xpath: "//div[@class='container']//h4" }
		BRAIN = { id: "brainsvg" }

	def initialize(driver)
		super
		visit '/usability'
	end

	def elements_present?
		is_displayed? HEADER
		(find(HEADER).text).include? "User Experience Research"
		is_displayed? HEAD
		(find(HEAD).text).should == "User Experience Research"
		is_displayed? SUBHEAD
		(find(SUBHEAD).text).should == "Help improve MasteryConnect products for the classroom."
	end

	def brain_there?
		sleep 3
		is_displayed? BRAIN
	end

end