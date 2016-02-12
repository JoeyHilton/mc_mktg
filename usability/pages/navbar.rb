require_relative 'base_page'

class Navbar < BasePage

		LOGO = { class: "logo" }
		DEMO = { link: "DEMO"}
		LOGIN = { link: "LOGIN" }

	def initialize(driver)
		super
		visit '/usability'
	end

	def links_present?
		(find(DEMO).text).should == "DEMO"
		(find(LOGIN).text).should == "LOGIN"
		is_displayed? LOGO
		is_displayed? DEMO
		is_displayed? LOGIN
		puts "MC Logo displayed" if wait.until {
			find(class: "logo").css_value("background-image").should == "url(\"https://www.masteryconnect.com/usability/img/logo.svg\")"
		}
	end
end