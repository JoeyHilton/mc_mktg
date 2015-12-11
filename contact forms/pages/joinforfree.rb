require_relative 'base_page'

class JoinForFree < BasePage

		FIRST_NAME = { id: "teacher_first_name" }
		LAST_NAME = { id: "teacher_last_name"}
		EMAIL = { id: "teacher_email" }
		ZIP_CODE = {id: "zip"}
		TITLE = { id: "contact_title"}
		PHONE = { id: "teacher_phone"}

	def initialize(driver)
		super
		visit '/pricing.html'
	end

	def with(firstname, lastname, email, zip)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type email, EMAIL
		type zip, ZIP_CODE
	end

	def enter(title, phone)
		type title, TITLE
		type phone, PHONE
	end

	def info_form_present?
		(@driver.find_element(:xpath, "//*[@id='pricing']/aside/div/div/header/h1").text).should == "Sign Up for a Free Account"
	end

	def success_message_present?
		(@driver.find_element(:xpath, "//*[@id='dialog']/div/div/h2").text).should == "Thank you for signing up!"
	end
	
end