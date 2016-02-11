require_relative 'base_page'

class Footer < BasePage

		TWITTER = { class: "icon-twitter" }
		EMAIL = { class: "icon-mail"}
		MC = { link: "MasteryConnect" }
		FOOTER = { xpath: "html/body/footer"}

	def initialize(driver)
		super
		goto
	end

	def links_present?
		is_displayed? TWITTER
		is_displayed? EMAIL
		(find(MC).text).should == "MasteryConnect"
		(find(FOOTER).text).include? "© 2016 Trenton Goble | Learn more about Trenton's work at MasteryConnect"
	end

end