require_relative 'base_page'

class Starbucks < BasePage

	INFO_FORM = { id: "more_info"}
		NAME_INPUT = { id: 'full_name'}
		ZIP_CODE = {id: 'zip_code'}
		EMAIL = { id: 'email' }
		HONEY = { id: 'user_email' }
		PHONE = { id: 'phone'}
		BUTTON = { id: "submit" }
		ALT_SCHOOL = { id: "school_list_alt" }
	SUCCESS_MODAL = { id: "form_success" }
		SUCCESS_BUTTON = { link: "OK, GOT IT" }

	def initialize(driver)
		super
		visit '/free-coffee/'
	end

	def with(name, zip, email, phone)
		type name, NAME_INPUT
		type zip, ZIP_CODE
		type email, EMAIL
		type phone, PHONE
	end

	def honeypot(honey)
		type honey, HONEY
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_button_present?
		is_displayed? SUCCESS_BUTTON
	end
	
end