require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def scrape_site_for_restaurants(url)
    restaurants = []
    site = Nokogiri::HTML(open(url))
    site = site.css("div.entry-content table tbody tr")
    site.each do |restaurant|
      restaurants << {restaurant.css("td")[1].css("a").text.strip => restaurant.css("td")[1].css("a").attribute("href").value}
      restaurants << {restaurant.css("td")[3].css("a").text.strip => restaurant.css("td")[3].css("a").attribute("href").value}
    end
    restaurants
  end

end 
