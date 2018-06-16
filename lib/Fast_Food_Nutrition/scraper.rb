require 'pry'
require 'Nokogiri'
require 'open-uri'

class Scraper
  def scrape_site_for_restaurants(url)
    site = Nokogiri::HTML(open(url))
    site = site.css("div.entry-content table tbody tr")
    site.each do |restaurant|
      Restaurant.new(restaurant.css("td")[1].css("a").text.strip, restaurant.css("td")[1].css("a").attribute("href").value)
      Restaurant.new(restaurant.css("td")[3].css("a").text.strip, restaurant.css("td")[3].css("a").attribute("href").value)
    end
    Restaurant.all.each do |location|
      puts "#{location.name}"
      location.categories = scrape_restaurant_categories(location)
      #binding.pry
    end
    binding.pry
  end

  def scrape_restaurant_categories(location)
    category_list = []
    url = "http://www.nutrition-charts.com/#{location.url}"
    site = Nokogiri::HTML(open(url))
    case location.name
    when "Burger King"
      site = site.css("div table tbody td h3")
      site.each do |item|
        category = Category.new(item.text)
        category.items = scrape_category_items(item.text, location)
        category_list << category
      end
      category_list
    when "Wendys"
      site = site.css("div table tbody td h3")
      site.each do |item|
        category = Category.new(item.text)
        category.items = scrape_category_items(item.text, location)
        category_list << category
      end
      category_list
    when "Buffalo Wild Wings"
      site = site.css("div table tbody td h3")
      site.each do |item|
        category = Category.new(item.text)
        category.items = scrape_category_items(item.text, location)
        category_list << category
      end
      category_list
    when "Pizza Hut"
      site = site.css("div table tbody td strong")
      site.each do |item|
        category = Category.new(item.text)
        category.items = scrape_category_items(item.text, location)
        category_list << category
      end
      category_list
    when "Applebees"
      site = site.css("div table tbody")
      site = site.css("tr.rowheader")
      site.each do |item|
        category = Category.new(item.css("td")[0].text)
        category.items = scrape_category_items(item.text, location)
        category_list << category
      end
      category_list
    when "Baja Fresh"
      site = site.css("div table tbody tr")
      site.each do |item|
        item.to_s.include?("<th>") ? category = Category.new(item.css("th")[0].text) : ""
        #category = Category.new(item.css("th")[0].text)
        if category
          category.items = scrape_category_items(item.text, location)
          category_list << category
        end
      end
      category_list
    else
      site = site.css("div table tbody")
      category = Category.new(site[0].css("tr")[0].css("th")[0].text)
      category.items = scrape_category_items(site[0].css("tr")[0].css("th")[0].text, location)
      category_list << category
      site = site.css("tr.rowheader")
      site.each do |item|
        category = Category.new(item.css("th")[0].text)
        category.items = scrape_category_items(item.text, location)
        category_list << category
      end
      category_list
    end
  end

  def scrape_category_items(item_name, location)
      item_list = []
      url = "http://www.nutrition-charts.com/#{location.url}"
      site = Nokogiri::HTML(open(url))
      case location.name
      when "Burger King"
        site = site.css("div table tbody tr")
        site.each do |item|
          if item.to_s.include?("<h3>")
            if item.css("h3")[0].text == item_name
              next_item = item.next_element
              begin
                if next_item.to_s.include?("<td>") && !next_item.to_s.include?("<span") && !next_item.to_s.include?("header")
                  item_list << Item.new(next_item.css("td")[0].text)
                end
                next_item = next_item.next_element
                next_item == nil ? next_item = "<h3>" : next_item
              end while !next_item.to_s.include?("<h3>")
            end
          end
        end
        item_list
      when "Wendys"
        site = site.css("div table tbody tr")
        site.each do |item|
          if item.to_s.include?("<h3>")
            if item.css("h3")[0].text == item_name
              next_item = item.next_element
              begin
                if next_item.to_s.include?("<td>") && !next_item.to_s.include?("<span") && !next_item.to_s.include?("header")
                  item_list << Item.new(next_item.css("td")[0].text)
                end
                next_item = next_item.next_element
                next_item == nil ? next_item = "<h3>" : next_item
              end while !next_item.to_s.include?("<h3>")
            end
          end
        end
        item_list
      when "Buffalo Wild Wings"
        site = site.css("div table tbody tr")
        site.each do |item|
          if item.to_s.include?("<h3>")
            if item.css("h3")[0].text == item_name
              next_item = item.next_element
              begin
                if next_item.to_s.include?("<td>") && !next_item.to_s.include?("<span") && !next_item.to_s.include?("header") && next_item.css("td")[0].text != " "
                  item_list << Item.new(next_item.css("td")[0].text)
                end
                next_item = next_item.next_element
                next_item == nil ? next_item = "<h3>" : next_item
              end while !next_item.to_s.include?("<h3>")
            end
          end
        end
        item_list
      when "Pizza Hut"
        site = site.css("div table tbody tr")
        site.each do |item|
          if item.to_s.include?("<strong>")
            if item.css("strong")[0].text == item_name
              next_item = item.next_element
              begin
                item_list << Item.new(next_item.css("td")[0].text) if !next_item.to_s.include?("<span")
                next_item = next_item.next_element
                next_item == nil ? next_item = "<strong>" : next_item
              end while !next_item.to_s.include?("<strong>")
            end
          end
        end
        item_list
      when "Applebees"
       site = site.css("div table tbody tr")
       site.each do |item|
          if item.to_s.include?("rowheader")
            if item.css("td")[0].text == item_name
              next_item = item.next_element
              begin
                item_list << Item.new(next_item.css("td")[0].text) if !next_item.to_s.include?("<span")
                next_item = next_item.next_element
                next_item == nil ? next_item = "<rowheader>" : next_item
              end while !next_item.to_s.include?("rowheader")
            end
          end
        end
        item_list
      else
      site = site.css("div table tbody tr")
      site.each do |item|
        if item.to_s.include?("<th>")
          if item.css("th")[0].text == item_name
            next_item = item.next_element
            begin
              item_list << Item.new(next_item.css("td")[0].text) if !next_item.to_s.include?("<span")
              next_item = next_item.next_element
              next_item == nil ? next_item = "<th>" : next_item
            end while !next_item.to_s.include?("<th>")
          end
        end
      end
      item_list
    end
  end

  def scrape_nutrition_info(item_name, item_site, restaurant)
    index = 1
    nutrition_list = []
    site = Nokogiri::HTML(open(item_site))
    case restaurant
    when "Burger King"
      nutrition_items = site.css("div table thead tr th")
      nutrition_items.each {|desc| nutrition_list << [desc.text.strip, ""]}
      site = site.css("div table tbody tr")
      site.each do |item|
        if item.to_s.include?("<td>")
          if item.css("td")[0].text == item_name
            i = 0
            while i < nutrition_list.length
              nutrition_list[i][1] = item.css("td")[i].text
              i += 1
            end
          end
        end
      end #do
      nutrition_list.shift
      nutrition_list
    when "Pizza Hut"
      nutrition_items = site.css("div table tbody tr th")
      nutrition_items.each {|desc| nutrition_list << [desc.text.strip, ""]}
      site = site.css("div table tbody tr")
      site.each do |item|
        if item.to_s.include?("<td>")
          if item.css("td")[0].text == item_name
            i = 0
            while i < nutrition_list.length
              nutrition_list[i][1] = item.css("td")[i].text
              i += 1
            end
          end
        end
      end #do
      nutrition_list.shift
      nutrition_list
    else
      nutrition_items = site.css("div table thead tr th")
      nutrition_items.each {|desc| nutrition_list << [desc.text.strip, ""]}
      site = site.css("div table tbody tr")
      site.each do |item|
        if item.to_s.include?("<td>")
          if item.css("td")[0].text == item_name
            i = 0
            while i < nutrition_list.length
              nutrition_list[i][1] = item.css("td")[i].text
              i += 1
            end
          end
        end
      end #do
      nutrition_list.shift
      nutrition_list
    end
  end
end
