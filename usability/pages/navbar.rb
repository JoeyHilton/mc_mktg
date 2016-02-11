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
		(find(DEMO.text).should == "DEMO"
		(find(LOGIN).text).should == "LOGIN"
		is_displayed? LOGO
		puts "MC Logo displayed" if wait.until {
			find(class: "logo").css_value("background-image").should == "url(\"https://www.masteryconnect.com/img/log.svg\")"
		}
	end

	def nav_links?
		window_switch :class, "logo", "https://www.masteryconnect.com"
		window_switch :link, "DEMO", "https://www.masteryconnect.com/request-a-demo.html"
		window_switch :link, "LOGIN", "https://app.masteryconnect.com/login"
	end

end