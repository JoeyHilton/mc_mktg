require_relative 'base_page'

class Home < BasePage

		RECLAIMH1 = { xpath: ".//*[@id='hero']/article/div[2]/h1" }
		BUY_BUTTON = { class: "book_link"}
		CHAPTER = { class: "chapter_link"}
		QUOTE = { class: "quote"}
		QUOTEMARK = { class: "quotemark"}
		NEWSH2 = { xpath: ".//*[@id='media']/article/h2"}
		MEETH2 = { xpath: ".//*[@id='author']/article/div[2]/h2"}
		MEDIA_PLAY = { class: "circle"}
		BIO = { link: "READ BIO"}
		BOOK = { xpath: "//img[@src='https://reclaimingtheclassroom.com/wp-content/themes/reclaim/img/book.jpg']"}

	def initialize(driver)
		super
		goto
	end

	def elements_present?
		page_title "Reclaiming The Classroom"
		is_displayed? RECLAIMH1
		(find(RECLAIMH1).text).should == "Reclaiming the Classroom"
		is_displayed? BUY_BUTTON
		is_displayed? CHAPTER
		is_displayed? QUOTEMARK
		is_displayed? QUOTE
		is_displayed? NEWSH2
		(find(NEWSH2).text).should == "News & Media"
		is_displayed? MEETH2
		(find(MEETH2).text).should == "Meet the Author"
		is_displayed? MEDIA_PLAY
		is_displayed? BIO
	end

	def hero_image?
		is_displayed? BOOK
	end

end