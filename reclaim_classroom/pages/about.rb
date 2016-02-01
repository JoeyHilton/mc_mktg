require_relative 'base_page'

class About < BasePage

		TRENTONH1 = { xpath: "html/body/section/div/div[2]/h2" }
		HEADSHOT = { id: "trenton"}
		MC = { link: "MasteryConnect"}

	def initialize(driver)
		super
		visit '/about'
	end

	def elements_present?
		is_displayed? TRENTONH1
		is_displayed? HEADSHOT
		is_displayed? MC
		(find(TRENTONH1).text).should == "Trenton Goble"
		page_title "Reclaiming The Classroom | Trenton Goble"
	end

end