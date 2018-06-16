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

  def scrape_restaurant_categories(category) 
    category_list = []
    url = "http://www.nutrition-charts.com/#{category.flatten[1]}"
    site = Nokogiri::HTML(open(url))
    case category.flatten[0]
    when "Burger King"
      site = site.css("div table tbody td h3")
      site.each do |item|
        category_list << item.text
      end
      category_list
    when "Wendys"
      site = site.css("div table tbody td h3")
      site.each do |item|
        category_list << item.text
      end
      category_list
    when "Buffalo Wild Wings"
      site = site.css("div table tbody td h3")
      site.each do |item|
        category_list << item.text
      end
      category_list
    when "Pizza Hut"
      site = site.css("div table tbody td strong")
      site.each do |item|
        category_list << item.text
      end
      category_list
    when "Applebees"
      site = site.css("div table tbody")
      site = site.css("tr.rowheader")
      site.each do |item|
        category_list << item.css("td")[0].text
      end
      category_list
    when "Baja Fresh"
      site = site.css("div table tbody tr")
      site.each do |item|
        item.to_s.include?("<th>") ? category_list << item.css("th")[0].text : ""
      end
      category_list
    else
      site = site.css("div table tbody")
      category_list << site[0].css("tr")[0].css("th")[0].text
      site = site.css("tr.rowheader")
      site.each do |item|
        category_list << item.css("th")[0].text
      end
      category_list
    end
  end
end
