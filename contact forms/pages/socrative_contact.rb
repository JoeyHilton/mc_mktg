require_relative 'base_page'

class SocrativeContact < BasePage
		EMAIL = { name: "user_email" }
		MESSAGE = { name: "user_description" }
		SUCCESS_MESSAGE = { link: "<< Go back home" }

	def initialize(driver)
		super
		goto
	end

	def with(email, message)
		type email, EMAIL
		type message, MESSAGE
	end

	def success_message_present?
		is_displayed? SUCCESS_MESSAGE
	end
	
end