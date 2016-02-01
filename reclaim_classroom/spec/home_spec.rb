require_relative 'spec_helper'
require_relative '../pages/home'

describe "home_page" do

  before(:each) do
    ENV['base_url'] ||= 'https://www.reclaimingtheclassroom.com'
    ENV['browser'] ||= 'firefox'
    @driver.manage.timeouts.implicit_wait = 30
    @home = Home.new(@driver)
  end

  it "tests_home_page" do 
    @home.elements_present?.should be true
    @home.window_switch(:class, "book_link", "http://www.amazon.com/Reclaiming-Classroom-Trenton-Goble/dp/1519636687/ref=sr_1_6?ie=UTF8&qid=1452796927&sr=8-6&keywords=reclaiming+the+classroom")
    @home.window_switch(:class, "chapter_link", "https://reclaimingtheclassroom.com/wp-content/uploads/2016/01/reclaimingTheClassroom-chapter1-1.pdf")
    @home.click(:class, "circle")
    @home.media_page?
    @home.go_back
    @home.click(:link, "READ BIO")
    @home.about_page?
    @home.go_back
    @home.find_trenton
  end
end