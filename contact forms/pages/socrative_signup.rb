require_relative 'base_page'

class SocrativeSignup < BasePage
	INFO_FORM = { id: "teacher-form" }
		FIRST_NAME = { id: 'first-name'}
		LAST_NAME = { id: 'last-name'}
		EMAIL = { id: "profile-email" }
		PASSWORD = { id: 'password'}
		ZIP = { id: 'zip-code'}
		ALT_SCHOOL = { id: 'school-name'}

	def initialize(driver)
		super
		visit '/'
	end

	def with(firstname, lastname, email)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type email, EMAIL
	end

	def password(password)
		type password, PASSWORD
	end

	def zip(zip)
		type zip, ZIP
	end

	def alt(schoolname)
		type schoolname, ALT_SCHOOL		
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def correct_url?
		(@driver.current_url).should == "https://b.socrative.com/login/teacher/#register-teacher"
	end

	def success_message_present?
		(@driver.find_element(:id, "success-message-pop-up-message").text).should == "Welcome to Socrative!\n\nCheck out our User Guide\nto find out all the cool things you can do."
	end
	
end