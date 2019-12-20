require 'nokogiri'
require 'open-uri'
require_relative './course.rb'
class Scraper
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  def get_page
    page_html=open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    @doc=Nokogiri::HTML(page_html)
  end
  def get_courses
    self.get_page
    @courses=@doc.css("#course-grid.block")
  end
  def make_courses
    self.get_courses.each do |course|
      c=Course.new
      c.title=course.search("h2").text.strip
      c.schedule=course.search("em").text.strip
      c.description=course.search("p").text.strip
    end
  end
end
