require_relative 'base_page'

class Webinar < BasePage
	INFO_FORM = { id: 'form_area_one' }
		FIRST_NAME = { name: "Name_First" }
		LAST_NAME = { name: "Name_Last"}
		TITLE = { name: "JobTitle"}
		PHONE = { name: "Phone"}
		EMAIL = { name: "Email" }

	def initialize(driver)
		super
		visit '/webinars.html'
	end

	def with(firstname, lastname, title, phone, email)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type title, TITLE
		type phone, PHONE
		type email, EMAIL
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_message_present?
		(@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thank you for registering for our Webinar!"
	end
	
end