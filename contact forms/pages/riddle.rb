require_relative 'base_page'

class Riddle < BasePage

	INFO_FORM = { xpath: "//*[@id='form']"}
		ANSWER = { xpath: "//*[@id='answer']" }
		FULL_NAME = { xpath: "//*[@id='full_name']"}
		ZIP_CODE = {xpath: "//*[@id='zip_code']"}
		EMAIL = { xpath: "//*[@id='email']" }
		PHONE = { xpath: "//*[@id='phone']"}
		BUTTON = { id: "submit" }
		ALT_SCHOOL = { id: "school_manual_input" }
	SUCCESS_FORM = { xpath: "//*[@id='lean_overlay']" }
		SUCCESS_MESSAGE = { xpath: "//*[@id='riddle_right']/div[1]/h3" }

	def initialize(driver)
		super
		visit '/riddle/'
	end

	def with(answer, fullname, zip, email, phone)
		type answer, ANSWER
		type fullname, FULL_NAME
		type zip, ZIP_CODE
		type email, EMAIL
		type phone, PHONE
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_form_present?
		is_displayed? SUCCESS_FORM
	end

	def success_message_present?
		is_displayed? SUCCESS_MESSAGE
	end
	
end