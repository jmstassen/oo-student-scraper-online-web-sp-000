require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    @students = []
    doc.css(".student-card").each do |card|
      name = card.css("h4").text
      location = card.css(".student-location").text
      profile_url = card.css("a").attribute("href").text
      student_hash = {:name=>name, :location=>location, :profile_url=>profile_url}
      @students << student_hash
    end
    @students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_quote = doc.css(".profile-quote").text

    profile_hash = {:profile_quote=>profile_quote}
  end

end

Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
