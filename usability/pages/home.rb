require_relative 'base_page'

class Home < BasePage

		WHAT = { link: "WHAT IT IS" }
		HOW = { link: "HOW IT WORKS" }
		FAQ = { link: "FAQ" }

	def initialize(driver)
		super
		visit '/usability/'
	end

	def elements_present?
		page_title "MasteryConnect Usability"
		is_displayed? WHAT
		(find(WHAT).text).should == "WHAT IT IS"
		is_displayed? HOW
		(find(HOW).text).should == "HOW IT WORKS"
		is_displayed? FAQ
		(find(FAQ).text).should == "FAQ"
	end

end