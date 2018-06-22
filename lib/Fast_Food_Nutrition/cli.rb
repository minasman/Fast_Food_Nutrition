class Welcome

  def intro
    puts "Welcome To The Fast Food Nutrition Finder"
    list_restaurants
  end

  def list_restaurants
    selection = 0
    puts "\nPlease select a Restaurant by number:"
    Scraper.new.scrape_site_for_restaurants("http://www.nutrition-charts.com/") if Restaurant.all.size == 0
    Restaurant.all.each_with_index {|restaurant, i| puts "#{i + 1}: #{restaurant.name}"}
    # consider #between?
    selection = gets.strip.to_i until selection.between?(1, Restaurant.all.size)
    puts "\nYou selected #{Restaurant.all[selection - 1].name}"
    select_category(Restaurant.all[selection - 1])
  end

  def select_category(restaurant)
    restaurant.categories = Scraper.new.scrape_restaurant_categories(restaurant) if !restaurant.categories
    selection = 0
    puts "\nPlease select a Category of Menu Items:"
    restaurant.categories.each_with_index {|category, i| puts "#{i + 1}: #{category.name}"}
    selection = gets.strip.to_i until selection > 0 && selection <= restaurant.categories.size
    puts "\nYou selected #{restaurant.categories[selection - 1].name}"
    select_item(restaurant, selection - 1)
  end

  def select_item(restaurant, cat_picked)
    restaurant.categories[cat_picked].items = Scraper.new.scrape_category_items(restaurant, cat_picked) if !restaurant.categories[cat_picked].items
    selection = 0
    puts "\nPlease select an item:"
    restaurant.categories[cat_picked].items.each_with_index do |item, i|
      puts "#{i + 1}: #{item.name}"
    end
    selection = gets.strip.to_i until selection > 0 && selection <= restaurant.categories[cat_picked].items.size
    puts "\nYou selected #{restaurant.categories[cat_picked].items[selection - 1].name}"
    get_nutrition(restaurant, cat_picked, selection - 1)
  end

  def get_nutrition(restaurant, cat_picked, item_picked)
    restaurant.categories[cat_picked].items[item_picked].nutrition = Scraper.new.scrape_nutrition_info(restaurant, cat_picked, item_picked) if !restaurant.categories[cat_picked].items[item_picked].nutrition
    puts "\nHere is the nutrition information for #{restaurant.categories[cat_picked].items[item_picked].name}:"
    restaurant.categories[cat_picked].items[item_picked].nutrition.each do |item|
      puts "  #{item[0]}: #{item[1]}"
    end
    continue?
  end

  def continue?
    input = ""
    puts "\nWould you like to continue to find more items? (y/n)"
    input = gets.strip.downcase until input == "y" || input == "n"
    input == "y" ? list_restaurants : bye
  end

  def bye
    puts "\nThank You for using the Fast Food Nutrition Finder"
  end

end
