require_relative 'base_page'

class SloA < BasePage

	INFO_FORM = { link: "GET MORE INFO"}
		FIRST_NAME = { id: 'first_name'}
		LAST_NAME = { id: 'last_name'}
		ZIP_CODE = {id: 'zip_code'}
		EMAIL = { id: 'email' }
		PHONE = { id: 'phone'}
		BUTTON = { id: "submit" }
		ALT_SCHOOL = { id: "school_list_alt" }
	SUCCESS_MODAL = { xpath: "//*[@id='form_success']/a" }
		SUCCESS_BUTTON = { css: "#form_success > div.modal_close" }

	def initialize(driver)
		super
		visit '/slo/forma.html'
	end

	def with(firstname, lastname, zip, email, phone)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type zip, ZIP_CODE
		type email, EMAIL
		type phone, PHONE
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_modal_present?
		is_displayed? SUCCESS_MODAL
	end
	
end