require_relative 'base_page'

class Footer < BasePage

		FOOTER1 = { xpath: "html/body/footer[1]"}
		FOOTER2 = { xpath: "html/body/footer[2]"}
		FACEBOOK = {class: "icon-facebook"}
		TWITTER = {class: "icon-twitter"}
		EMAIL = {class: "email"}

	def initialize(driver)
		super
		goto
	end

	def elements_present?
		(find(FOOTER1).text).include? "MasteryCon is the ultimate K-12 event for mastery learning and formative assessment."
		(find(FOOTER1).text).include? "Tour the MasteryConnect Learning platform."
		puts "mc logo is in the footer".green if wait.until {
			find(class: "mc_logo").css_value("background-image").should == "url(\"http://www.masterycon.com/img/mc_logo.svg\")"
		}
		is_displayed? FACEBOOK
		is_displayed? TWITTER
		is_displayed? EMAIL
		(find(EMAIL).text).should == "Email Us"
	end

end

