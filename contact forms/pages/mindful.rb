require_relative 'base_page'

class Mindful < BasePage
	INFO_FORM = { id: 'form' }
		FULL_NAME = { id: "full_name" }
		EMAIL = { id: "email" }
		PHONE = { id: "phone"}
		ZIP = { id: "zip_code"}
		ALT_SCHOOL = { id: "school_manual_input" }

	def initialize(driver)
		super
		visit '/mindful.html'
	end

	def with(fullname, email, phone, zip)
		type fullname, FULL_NAME
		type email, EMAIL
		type phone, PHONE
		type zip, ZIP
	end

	def alt(altschool)
		type altschool, ALT_SCHOOL
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_message_present?
		(@driver.find_element(:xpath, "//*[@id='form_success']/h2").text).should == "Thanks!"
	end
	
end