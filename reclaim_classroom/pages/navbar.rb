require_relative 'base_page'

class Navbar < BasePage

		HOME = { id: "menu-item-69" }
		MEDIA = { id: "menu-item-70"}
		ABOUT = { id: "menu-item-73" }
		BUY = {id: "menu-item-74"}

	def initialize(driver)
		super
		visit '/media.html'
	end

	def links_present?
		(@driver.find_element(HOME).text).should == "HOME"
		(@driver.find_element(MEDIA).text).should == "PODCAST & MORE"
		(@driver.find_element(ABOUT).text).should == "ABOUT TRENTON"
		(@driver.find_element(BUY).text).should == "BUY BOOK"
	end

	def media_page?
		(@driver.current_url).should == "https://reclaimingtheclassroom.com/media/"
	end

end