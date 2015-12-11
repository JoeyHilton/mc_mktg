require_relative 'base_page'

class McContact < BasePage

	INFO_FORM = { id: "form_area_one"}
		FIRST_NAME = { name: "first_name" }
		LAST_NAME = { name: "last_name"}
		TITLE = { name: "title" }
		ZIP_CODE = {id: "zip"}
		EMAIL = { name: "email" }
		PHONE = { name: "phone"}
		MESSAGE = { class: "message" }
		BUTTON = { xpath: "//*[@id='form_area_one']/button" }
		ALT_SCHOOL = { id: "school_list_alt" }
	SUCCESS_FORM = { xpath: "//*[@id='lean_overlay']" }
		SUCCESS_MESSAGE = { xpath: "//*[@id='request_form']/div/div[1]/h3" }

	def initialize(driver)
		super
		visit '/contact_us.html'
	end

	def with(firstname, lastname, title, email, phone, message)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type title, TITLE
		type email, EMAIL
		type phone, PHONE
		type message, MESSAGE
	end

	def send(zip)
		type zip, ZIP_CODE
	end

	def enter(altschool)
		type altschool, ALT_SCHOOL
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_form_present?
		is_displayed? SUCCESS_FORM
	end

	def success_message_present?
		@driver.current_url.should == "https://www.masteryconnect.com/thank-you-contact.html"
	end
	
end