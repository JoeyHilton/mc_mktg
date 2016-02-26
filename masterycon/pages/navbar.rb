require_relative 'base_page'

class Navbar < BasePage

		SPEAKERS = { link: "Call for Speakers" }
		ATTEND = { link: "Why Attend"}
		LODGING = { link: "Lodging" }
		REGISTER = { link: "Register" }

	def initialize(driver)
		super
		goto
	end

	def links_present?
		(find(SPEAKERS).text).should == "Call for Speakers"
		(find(ATTEND).text).should == "Why Attend"
		(find(LODGING).text).should == "Lodging"
		(find(REGISTER).text).should == "Register"
		is_displayed? SPEAKERS
		is_displayed? ATTEND
		is_displayed? LODGING
		is_displayed? REGISTER
		puts "camp graphic displayed".green if wait.until {
			find(class: "mcon_hipster").css_value("background-image").should == "url(\"http://www.masterycon.com/img/mcon_hipster.svg\")"
		}
		puts "nav background color is brown".green if wait.until {
			find(xpath: "html/body/section[1]/header/nav").css_value("background-color").should == "rgba(89, 79, 71, 1)"
		}
	end

	def not_present?
		is_displayed? SPEAKERS
	end
end