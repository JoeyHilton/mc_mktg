require_relative 'base_page'

class SloB < BasePage

	INFO_FORM = { id: "requestForm"}
		FULL_NAME = { id: 'full_name'}
		ZIP_CODE = {id: 'zip_code'}
		EMAIL = { id: 'email' }
		PHONE = { id: 'phone'}
		BUTTON = { id: "submit" }
		ALT_SCHOOL = { id: "school_list_alt" }
	SUCCESS_CHECK = { class: "icon-checkmark" }
		# SUCCESS_BUTTON = { css: "#form_success > div.modal_close" }

	def initialize(driver)
		super
		visit '/slo/formb.html'
	end

	def with(fullname, zip, email, phone)
		type fullname, FULL_NAME
		type zip, ZIP_CODE
		type email, EMAIL
		type phone, PHONE
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def success_check_present?
		is_displayed? SUCCESS_CHECK
	end
	
end