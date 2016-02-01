require_relative 'base_page'

class Navbar < BasePage

		HOME = { id: "menu-item-69" }
		MEDIA = { id: "menu-item-70"}
		ABOUT = { id: "menu-item-73" }
		BUY = {id: "menu-item-74"}

	def initialize(driver)
		super
		visit '/media'
	end

	def links_present?
		(find(HOME).text).should == "HOME"
		(find(MEDIA).text).should == "PODCAST & MORE"
		(find(ABOUT).text).should == "ABOUT TRENTON"
		(find(BUY).text).should == "BUY BOOK"
	end

	def buy_link?
		window_switch :id, "menu-item-74", "http://www.amazon.com/Reclaiming-Classroom-Trenton-Goble/dp/1519636687/ref=sr_1_6?ie=UTF8&qid=1452796927&sr=8-6&keywords=reclaiming+the+classroom"
	end

end