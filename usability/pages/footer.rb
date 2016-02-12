require_relative 'base_page'

class Footer < BasePage

		WALLST = { class: "icon-twitter" }
		EDUTOPIA = { class: "icon-mail"}
		TC = { link: "MasteryConnect" }
		FOOTER = { xpath: "html/body/footer"}

	def initialize(driver)
		super
		visit '/usability'
	end

	def elements_present?
		(find(FOOTER).text).include? "© Copyright 2016 MasteryConnect. All Rights Reserved."
		puts "All the logos in the footer are displayed" if wait.until {
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/wsj.svg']").displayed?
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/edutopia.svg']").displayed?
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/tc.svg']").displayed?
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/forbes.svg']").displayed?
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/mashable.svg']").displayed?
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/huffpost.svg']").displayed?
			@driver.find_element(:xpath, "//div[contains(@class, 'media')]//img[@src='img/edsurge.svg']").displayed?
		}
	end

end

