require_relative 'base_page'

class RequestDemo < BasePage

		FIRST_NAME = { name: "first_name" }
		LAST_NAME = { name: "last_name"}
		EMAIL = { name: "email" }
		ZIP_CODE = {id: "zip"}
		TITLE = { name: "title"}
		PHONE = { name: "phone"}
		ALT_SCHOOL = { id: "school_list_alt" }
		MAN_ORG = { id: 'manualOrg' }
		SCHOOL = { id: 'notUSSchool' }
		ORG = { id: 'notUSDistrict' }
		COUNTRY = { name: 'country' }

	def initialize(driver)
		super
		visit '/request-a-demo.html'
	end

	def with(firstname, lastname, title, phone, email, zip)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type title, TITLE
		type phone, PHONE
		type email, EMAIL
		type zip, ZIP_CODE
	end

	def nopart(firstname, lastname, title, phone, email)
		type firstname, FIRST_NAME
		type lastname, LAST_NAME
		type title, TITLE
		type phone, PHONE
		type email, EMAIL
	end

	def alt(altschool)
		type altschool, ALT_SCHOOL
	end

	def org(manorg)
		type manorg, MAN_ORG
	end

	def outside_us(school, org, country)
		type school, SCHOOL
		type org, ORG 
		type country, COUNTRY
	end

	def info_form_present?
		(@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "PLEASE FILL OUT THE CONTACT FORM AND WE'LL BE IN TOUCH!"
	end

	def success_message_present?
		(@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thanks for contacting MasteryConnect!"
	end
	
end