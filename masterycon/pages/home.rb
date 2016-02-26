require_relative 'base_page'

class Home < BasePage

		WHAT = { link: "WHAT IT IS" }
		HOW = { link: "HOW IT WORKS" }
		FAQ = { link: "FAQ" }
		SIGN_UP = { class: "button" }
		UNSUB = { link: "Unsubscribe" }

	def initialize(driver)
		super
		goto
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

	def signup_button?
		is_displayed? SIGN_UP
		(find(SIGN_UP).text).should == "SIGN ME UP"
	end

	def what_section?
		@driver.find_element(xpath: "//section[@id='what']//h3[contains(text(), 'Why')]").displayed?
		@driver.find_element(xpath: "//section[@id='what']//h3[contains(text(), 'What it is')]").displayed?
		@driver.find_element(xpath: "//section[@id='what']//h3[contains(text(), 'Who can participate')]").displayed?
		is_displayed? SIGN_UP
	end

	def how_section?
		@driver.find_element(xpath: "//section[@id='how']//small[contains(text(), 'Sign up to be contacted')]").displayed?
		@driver.find_element(xpath: "//section[@id='how']//small[contains(text(), 'We’ll contact you if we think you may be a good match')]").displayed?
		@driver.find_element(xpath: "//section[@id='how']//small[contains(text(), 'After the study,')]").displayed?
		is_displayed? SIGN_UP
	end

	def faq_section?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'What am I signing up for?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'What kind of people are you looking for?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'What would I do in a research study?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'I don’t live near the MasteryConnect Salt Lake City office. Can I still sign up?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'What do I get for signing up?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'When will you contact me?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'What’s the time commitment?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'I don’t use MasteryConnect. Can I still sign up?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'If I sign up, are you going to spam my email or sell my information to other companies?')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//h3[contains(text(), 'I signed up, but no longer want to participate. How do I opt out?')]").displayed?
		is_displayed? SIGN_UP
		is_displayed? UNSUB
		(find(UNSUB).text).should == "Unsubscribe"
	end

	def faq_subheads?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Here are some of the different studies we may conduct:')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Usability study at MasteryConnect')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Remote usability study')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Site visit or field study')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Phone interview')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Survey')]").displayed?
		@driver.find_element(xpath: "//section[@id='faq']//b[contains(text(), 'Diary study')]").displayed?
	end

end