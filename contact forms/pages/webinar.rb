require_relative 'base_page'

class Webinar < BasePage
	INFO_FORM = { id: 'form_area_one' }
		FIRST_NAME = { name: "Name_First" }
		LAST_NAME = { name: "Name_Last"}
		TITLE = { name: "JobTitle"}
		PHONE = { name: "Phone"}
		EMAIL = { name: "Email" }

		FULL_NAME = { id: "full_name" }
		JOB_TITLE = { id: "job_title" }
		PHONE_NUMBER = { id: "phone" }
		EMAIL2 = { id: "email" }
		HEADER = { xpath: ".//*[@id='feature_area']/div/div/div/h1"}
		PLAYER = { id: "player" }

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

	def with_this(fullname, title, phone, email)
		type fullname, FULL_NAME
		type title, JOB_TITLE
		type phone, PHONE_NUMBER
		type email, EMAIL2
	end

	def info_form_present?
		is_displayed? INFO_FORM
	end

	def correct_page?
		current_url("https://www.masteryconnect.com/recorded-webinar.html?t=TWFzdGVyeU1hdHRlcnM=&s=RnJvbSBSZW1lZGlhdGlvbiB0byBUb3AgMTAgd2l0aCBEYXRhLURyaXZlbiBJbnN0cnVjdGlvbg==")
		find(HEADER).text.should == "Recorded Webinar"
	end

	def video?
		is_displayed? PLAYER
	end

	def success_message_present?
		(@driver.find_element(:xpath, "//*[@id='request_form']/div/div[1]/h3").text).should == "Thank you for registering for our Webinar!"
	end
	
end