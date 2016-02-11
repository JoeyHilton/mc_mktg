require_relative 'spec_helper'
require_relative '../pages/home'

describe "home_page" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.reclaimingtheclassroom.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @home = Home.new(@driver)
  end

  it "tests_presence_of_elements" do 
    puts "Home Page elements found and verified" if @home.wait.until {
      @home.elements_present?.should be true
    }
  end

  it "tests_buy_button" do
    @home.window_switch(:class, "book_link", "http://www.amazon.com/Reclaiming-Classroom-Trenton-Goble/dp/1519636687/ref=sr_1_6?ie=UTF8&qid=1452796927&sr=8-6&keywords=reclaiming+the+classroom")
  end

  it "tests_free_chapter_button" do
    @home.window_switch(:class, "chapter_link", "https://reclaimingtheclassroom.com/wp-content/uploads/2016/01/reclaimingTheClassroom-chapter1-1.pdf")
  end

  it "tests_links_on_page" do
    @home.click(:class, "circle")
    @home.media_page?
    @home.go_back
    @home.click(:link, "READ BIO")
    @home.about_page?
    @home.go_back
  end

  it "tests_book_image" do
    puts "Big Book Pic is there" if @home.wait.until {
      @home.hero_image?
    }
  end

  it "tests_trenton_pic_is_there" do
    @home.find_trenton
  end
end