require_relative 'base_page'

class Media < BasePage

		HEADER = { xpath: ".//*[@id='podcast']/div/div[1]/h1" }
		ARTICLES = { xpath: ".//*[@id='podcast']/div/div[2]/h2[1]"}
		NEWS = { xpath: ".//*[@id='podcast']/div/div[2]/h2[2]"}

	def initialize(driver)
		super
		visit '/media'
	end

	def elements_present?
		is_displayed? HEADER
		is_displayed? ARTICLES
		is_displayed? NEWS
		(find(HEADER).text).should == "Podcast"
		(find(ARTICLES).text).include? "ARTICLES FROM TRENTON"
		(find(NEWS).text).include? "TRENTON IN THE NEWS"
		page_title "Reclaiming The Classroom | Podcast"
	end

	def external_articles?
		window_switch :link, "The Role of Tech and Data in Personalizing Education, published in Innovation Insights", "http://insights.wired.com/profiles/blogs/the-role-of-technology-data-in-personalizing-education#axzz3xEcLNTxC"
		window_switch :link, "Ed Tech Should Learn from Educators, published for Michael & Susan Dell Foundation", "http://www.msdf.org/blog/2013/06/trenton-goble-ed-tech-should-learn-from-educators/"
		window_switch :link, "Meaningful Assessment and the Garden Shed, published for Education Week", "http://blogs.edweek.org/edweek/rick_hess_straight_up/2012/07/meaningful_assessment_and_the_garden_shed.html"
		window_switch :link, "It Takes More Than a Minute to Win It, published for Education Week", "http://blogs.edweek.org/edweek/rick_hess_straight_up/2012/07/it_takes_more_than_a_minute-to-win-it.html"
		window_switch :link, "Is All of This Testing Really Necessary?, published for Education Week", "http://blogs.edweek.org/edweek/rick_hess_straight_up/2012/07/is_all_of_this_testing_really_necessary.html"
		window_switch :link, "Leadership and the PLC, published for All Things PLC", "http://www.allthingsplc.info/blog/view/193/leadership-and-the-plc"
		window_switch :link, "Daily Edventures", "http://dailyedventures.com/index.php/2014/01/28/masteryconnect/"
		window_switch :link, "K-12 Tech Decisions", "http://www.k-12techdecisions.com/article/the_problem_with_big_data_in_k_12_education#"
		window_switch :link, "Smart Cities: EduPreneurs Series", "http://gettingsmart.com/2013/10/new-podcast-edupreneurs-edreach-network/"
	end

end